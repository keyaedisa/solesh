#!/bin/bash

# Define the BAITER_WALLET variable
BAITER_WALLET=$1

# Extract all addresses in the "accountKeys" array, remove the one matching BAITER_WALLET and any addresses made of only '1'
grep -oP '(?<="accountKeys":\[)[^\]]*' transactions.json |
  tr -d '"' | tr ',' '\n' | grep -v "$BAITER_WALLET" | grep -v "^1\{32\}$"
