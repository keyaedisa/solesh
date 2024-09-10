#!/bin/bash

# Define the Solana API URL for getTransaction
URL="https://api.mainnet-beta.solana.com"

# The file containing the signatures (one per line)
SIGNATURE_FILE="grepOut" # Replace with the actual filename

# Loop through each signature in the file
while IFS= read -r signature; do

  # Check if the signature is not empty
  if [ -n "$signature" ]; then
    # Build the JSON payload for getTransaction
    JSON_PAYLOAD=$(
      cat <<EOF
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "getTransaction",
  "params": [
    "$signature",
    {
      "encoding": "json",
      "maxSupportedTransactionVersion": 0
    }
  ]
}
EOF
    )

    # Send the curl request
    echo "Fetching transaction for signature: $signature"
    curl -X POST "$URL" \
      -H "Content-Type: application/json" \
      -d "$JSON_PAYLOAD" \
      --silent >>getTranOut
    #--fail ||
    #echo "Failed to fetch transaction for $signature" >>getTranTest

    # Optionally, introduce a small delay between requests to avoid rate limiting
    sleep 3
  fi

done <"$SIGNATURE_FILE"
