#!/bin/bash

# Exit on error
set -e

# Variables
RESOURCE_GROUP="my-nodejs-rg"
LOCATION="westeurope"
APP_SERVICE_PLAN="my-nodejs-plan"
APP_NAME="my-nodejs-app"
RUNTIME="NODE|16-lts"
DEPLOYMENT_PACKAGE="release.zip"
DEPLOYMENT_SOURCE_DIR="./"

# Check for Azure CLI
if ! command -v az &> /dev/null; then
  echo "Azure CLI not found. Please install it: https://learn.microsoft.com/cli/azure/install-azure-cli"
  exit 1
fi

# Create Resource Group
echo "Creating resource group: $RESOURCE_GROUP..."
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

# Create App Service Plan
echo "Creating App Service Plan: $APP_SERVICE_PLAN..."
az appservice plan create --name "$APP_SERVICE_PLAN" \
  --resource-group "$RESOURCE_GROUP" \
  --sku B1 \
  --is-linux

# Create App Service
echo "Creating App Service: $APP_NAME..."
az webapp create --name "$APP_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --plan "$APP_SERVICE_PLAN" \
  --runtime "$RUNTIME"

# Package the app
echo "Packaging the app into $DEPLOYMENT_PACKAGE..."
if [ -f "$DEPLOYMENT_PACKAGE" ]; then
  rm "$DEPLOYMENT_PACKAGE"
fi
zip -r "$DEPLOYMENT_PACKAGE" "$DEPLOYMENT_SOURCE_DIR" -x "scripts/*"

# Deploy the app
echo "Deploying $DEPLOYMENT_PACKAGE to Azure App Service: $APP_NAME..."
az webapp deployment source config-zip \
  --resource-group "$RESOURCE_GROUP" \
  --name "$APP_NAME" \
  --src "$DEPLOYMENT_PACKAGE"

# Output the app URL
APP_URL="https://${APP_NAME}.azurewebsites.net"
echo "Deployment successful! Your app is live at: $APP_URL"
