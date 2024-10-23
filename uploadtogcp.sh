#!/bin/bash

<<<<<<< HEAD
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

# Ask for GCP Storage Bucket Name
read -p "Enter Google Cloud Storage Bucket Name: " GCP_BUCKET

# Check if the file already exists in GCP Storage
gsutil ls "gs://$GCP_BUCKET/$(basename "$FILE_PATH")" > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "File already exists in Google Cloud Storage bucket."
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

# Upload file to GCP Storage with progress bar
cat "$FILE_PATH" | pv | gsutil cp - "gs://$GCP_BUCKET/$(basename "$FILE_PATH")"
=======
# Check if file path is provided
if [ -z "$1" ]; then
  echo "Please provide the path of the file you want to upload to Google Cloud Storage."
  exit 1
fi

# Check if file exists
if [ ! -f "$1" ]; then
  echo "Error: File does not exist at the specified path."
  exit 1
fi

# Specify GCP bucket name
read -p "Enter GCP Storage Bucket Name: " BUCKET_NAME

# Upload file to GCP Storage
gsutil cp "$1" gs://$BUCKET_NAME/
>>>>>>> gcp-uploader

# Check if the upload was successful
if [ $? -eq 0 ]; then
    echo "File uploaded successfully to Google Cloud Storage."
else
<<<<<<< HEAD
    echo "Error: Failed to upload file."
fi
=======
    echo "Error: Failed to upload the file."
fi
>>>>>>> gcp-uploader
