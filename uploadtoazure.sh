#!/bin/bash

# Check if a file path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/your/file"
    exit 1
fi

FILE_PATH=$1

# Check if file exists locally
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Ask for Azure Storage Account Name and Container Name
read -p "Enter Azure Storage Account Name: " AZURE_STORAGE_ACCOUNT
read -p "Enter Azure Storage Container Name: " AZURE_CONTAINER

# Check if file already exists in Azure Blob Storage
az storage blob show --account-name "$AZURE_STORAGE_ACCOUNT" --container-name "$AZURE_CONTAINER" --name "$(basename "$FILE_PATH")" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "File already exists in Azure container."
    read -p "Do you want to overwrite (o), skip (s), or rename (r)? " choice
    case "$choice" in
        o) 
            echo "Overwriting file..."
            ;;
        s) 
            echo "Skipping upload."
            exit 0
            ;;
        r) 
            read -p "Enter new name: " new_name
            FILE_PATH=$(dirname "$FILE_PATH")/$new_name
            ;;
        *) 
            echo "Invalid choice."
            exit 1
            ;;
    esac
fi

# Upload file to Azure Blob Storage with progress bar
cat "$FILE_PATH" | pv | az storage blob upload --account-name "$AZURE_STORAGE_ACCOUNT" --container-name "$AZURE_CONTAINER" --name "$(basename "$FILE_PATH")" --file "$FILE_PATH"

# Check if the upload was successful
if [ $? -eq 0 ]; then
    echo "File uploaded successfully to Azure Blob Storage."
else
    echo "Error: Failed to upload file."
fi
