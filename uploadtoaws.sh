#!/bin/bash

# Check if a file path is provided as the first argument
if [ -z "$1" ]; then
  echo "Please provide the path of the file you want to upload to your AWS S3 bucket."
  exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
  echo "File does not exist at the specified path."
  exit 1
fi

# Define the S3 bucket (we'll prompt the user for this)
echo "Enter the S3 bucket name:"
read BUCKET_NAME

# Upload the file to S3
aws s3 cp "$1" "s3://$BUCKET_NAME/"

if [ $? -eq 0 ]; then
  echo "File uploaded successfully!"
else
  echo "File upload failed."
  exit 1
fi