#!/bin/bash

# Exit on error
set -e

# Variables
RESOURCE_GROUP="pixelvault-nodejs-rg"

# Start all App Services
echo "Starting all App Services in resource group: $RESOURCE_GROUP..."
APPS=$(az webapp list --resource-group "$RESOURCE_GROUP" --query "[].name" -o tsv)
for APP in $APPS; do
  echo "Starting App Service: $APP..."
  az webapp start --name "$APP" --resource-group "$RESOURCE_GROUP"
done

# Start all Virtual Machines (if any)
echo "Starting all Virtual Machines in resource group: $RESOURCE_GROUP..."
VMS=$(az vm list --resource-group "$RESOURCE_GROUP" --query "[].name" -o tsv)
for VM in $VMS; do
  echo "Starting Virtual Machine: $VM..."
  az vm start --name "$VM" --resource-group "$RESOURCE_GROUP"
done

echo "All resources in $RESOURCE_GROUP have been started."
