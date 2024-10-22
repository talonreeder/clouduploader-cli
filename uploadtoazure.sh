#!/bin/bash

# Check if file path is provided
if [ -z "$1" ]; then
  echo "Please provide the path of the file you want to upload to Azure Blob Storage."
  exit 1
fi

# Check if file exists
if [ ! -f "$1" ]; then
  echo "Error: File does not exist at the specified path."
  exit 1
fi

# Specify storage account name and container name that file will be uploaded to
read -p "Enter Azure Storage Account Name: " STORAGE_ACCOUNT
read -p "Enter Azure Blob Container Name: " CONTAINER_NAME

# Upload file to Azure Blob Storage
az storage blob upload --account-name "$STORAGE_ACCOUNT" --container-name "$CONTAINER_NAME" --file "$FILE_PATH" --name "$(basename $1)"

# Check if the upload was successful
if [ $? -eq 0 ]; then
    echo "File uploaded successfully to Azure Blob Storage."
else
    echo "Error: Failed to upload the file."
fi