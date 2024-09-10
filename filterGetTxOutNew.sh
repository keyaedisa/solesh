#!/bin/bash

# Define the BAITER_WALLET variable
BAITER_WALLET="YourBaiterWalletAddressHere"

# Initialize a counter
counter=1

# Extract and label the accountKeys, remove duplicates, remove BAITER_WALLET, and unwanted addresses
echo "Account Keys:" >txs

grep -oP '(?<="accountKeys":\[)[^\]]*' getTranOut |
  tr -d '"' | tr ',' '\n' | grep -v "$BAITER_WALLET" | grep -v "^1\{32\}$" | grep -v "^ComputeBudget" |
  sort | uniq | while read -r address; do
  # Add the numbered label
  echo "$counter:" >>txs

  # Add the account key label and the address
  echo "account key: $address" >>txs

  # Add the Solscan label and the link
  echo "solscan: https://solscan.io/account/$address" >>txs

  # Add the Cielo label and the link
  echo "cielo: https://app.cielo.finance/profile/$address/pnl/tokens?sortBy=pnl_desc" >>txs

  # Optional: Add a separator for better readability (e.g., a blank line between addresses)
  echo "" >>txs

  # Increment the counter
  counter=$((counter + 1))

done
