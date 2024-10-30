# CloudUploader CLI
A bash-based CLI tool that allows you to quickly upload files to AWS S3, Azure Blob Storage, and Google Cloud Storage. The tool supports concurrent multi-file uploads with error handling and progress bars, making it ideal for managing large batches of files.

## Features
* Upload files to AWS S3, Azure Blob Storage, and Google Cloud Storage <br/>
* Synchronize multiple files in a single command <br/>
* Real-time progress bars for each file upload <br/>
* Error handling and logging for reliable performance <br/>

## Prerequisites
* Bash <br/>
* AWS CLI <br/>
* Azure CLI <br/>
* Google Cloud SDK <br/>
* Git

## Installation
1. Clone the repository: <br/>
```
git clone https://github.com/talonreeder/clouduploader-cli.git
```
2. Navigate to the directory of the tool on your machine
```
cd clouduploader-cli
```
3. Ensure you have valid configurations and credentials for each provider: <br/>
* **AWS S3:** Configure your AWS credentials in `~/.aws/credentials` and verify using `aws configure`.
* **Azure Blob Storage:** Set up your Azure CLI with `az login`.
* **Google Cloud Storage:** Authenticate your GCP credentials using `gcloud auth login`.

## Usage
To upload one or multiple files to AWS S3, Azure Blob Storage, or Google Cloud Storage, use one of the following commands according to which cloud provider you wish to upload to: <br/><br/>
**AWS S3:**
```
./uploadtoaws.sh /path/to/file.txt
```
**Azure Blob Storage:**
```
./uploadtoazure.sh /path/to/file.txt
```
**Google Cloud Storage:**
```
./uploadtogcp.sh /path/to/file.txt
```
<br/>

To upload multiple files, use the above designated command according to your cloud provider, adding the path of the additional file. <br/><br/>
**For example:**
```
./uploadtoaws.sh /path/to/file.txt /path/to/second/file.txt
```

## Contributing
Contributions are welcome! Please open an issue or submit a pull request to propose any improvements. Enjoy!
