#!/bin/bash

# Exit on error
set -e

# Variables
RESOURCE_GROUP="my-nodejs-rg"

# Delete the resource group
echo "Deleting resource group: $RESOURCE_GROUP..."
az group delete --name "$RESOURCE_GROUP" --yes --no-wait

echo "Resource group $RESOURCE_GROUP and all its resources have been deleted."
