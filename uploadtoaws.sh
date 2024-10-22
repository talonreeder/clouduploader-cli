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

# Ask for AWS S3 bucket name
read -p "Enter S3 Bucket Name: " BUCKET_NAME

# Check if file already exists in S3
aws s3 ls "s3://$BUCKET_NAME/$(basename "$FILE_PATH")" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "File already exists in the bucket."
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

# Upload file to S3 with progress bar
cat "$FILE_PATH" | pv | aws s3 cp - "s3://$BUCKET_NAME/$(basename "$FILE_PATH")"

# Check if upload was successful
if [ $? -eq 0 ]; then
    echo "File uploaded successfully to S3."
else
    echo "Error: Failed to upload file."
fi