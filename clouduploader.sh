#!/bin/bash

# Azure Storage Account Information
account_name="demo202425"
account_key="Cs64A6v1C+EBBgFOs+FyyknjjvfSY+KiDDR+8z3aC3gBk8J11fyUjnMUbVeM0/GvnEgCmGG7o7ky+AStnHOnvA=="
container_name="demo"

# File to Upload
file_path="$1"

# Check if file_path is provided
if [ -z "$file_path" ]; then
  echo "Usage: $0 <file_path>"
  exit 1
fi

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo "Azure CLI is not installed. Please install it first."
    exit 1
fi

# Authenticate with Azure CLI
az login

# Upload the file to Azure Blob Storage
az storage blob upload \
  --account-name $account_name \
  --account-key $account_key \
  --container-name $container_name \
  --type block \
  --name "$(basename "$file_path")" \
  --content-type "application/octet-stream" \
  --content-encoding "gzip" \
  --file "$file_path"

echo "File successfully uploaded to Azure Blob Storage."
