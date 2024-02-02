#!/bin/bash

# Default Azure Storage Account Information
default_account_name="your_default_account_name"
default_account_key="your_default_account_key"
default_container_name="your_default_container_name"

# File to Upload
file_path="$1"

# Set default values if not provided
account_name="${2:-$default_account_name}"
account_key="${3:-$default_account_key}"
container_name="${4:-$default_container_name}"

# Check if file_path is provided
if [ -z "$file_path" ]; then
  echo "Usage: $0 <file_path> [account_name] [account_key] [container_name]"
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
