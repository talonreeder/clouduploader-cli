#!/bin/bash

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

# Check if the upload was successful
if [ $? -eq 0 ]; then
    echo "File uploaded successfully to Google Cloud Storage."
else
    echo "Error: Failed to upload the file."
fi