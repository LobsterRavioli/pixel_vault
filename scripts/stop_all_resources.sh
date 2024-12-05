#!/bin/bash

# Exit on error
set -e

# Variables
RESOURCE_GROUP="pixelvault-nodejs-rg"

# Stop all App Services
echo "Stopping all App Services in resource group: $RESOURCE_GROUP..."
APPS=$(az webapp list --resource-group "$RESOURCE_GROUP" --query "[].name" -o tsv)
for APP in $APPS; do
  echo "Stopping App Service: $APP..."
  az webapp stop --name "$APP" --resource-group "$RESOURCE_GROUP"
done

# Stop all Virtual Machines (if any)
echo "Stopping all Virtual Machines in resource group: $RESOURCE_GROUP..."
VMS=$(az vm list --resource-group "$RESOURCE_GROUP" --query "[].name" -o tsv)
for VM in $VMS; do
  echo "Stopping Virtual Machine: $VM..."
  az vm stop --name "$VM" --resource-group "$RESOURCE_GROUP"
done

echo "All resources in $RESOURCE_GROUP have been stopped."
