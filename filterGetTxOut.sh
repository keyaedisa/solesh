#!/bin/bash

# Define the BAITER_WALLET variable
BAITER_WALLET="YourBaiterWalletAddressHere"

# Extract and label the accountKeys, remove duplicates, remove BAITER_WALLET, and unwanted addresses
echo "Account Keys:"
grep -oP '(?<="accountKeys":\[)[^\]]*' getTranOut |
  tr -d '"' | tr ',' '\n' | grep -v "$BAITER_WALLET" | grep -v "^1\{32\}$" | grep -v "^ComputeBudget" |
  sort | uniq | sed 's/^/accountKeys: /' >>txs

grep -oP '(?<="accountKeys":\[)[^\]]*' getTranOut |
  tr -d '"' | tr ',' '\n' | grep -v "$BAITER_WALLET" | grep -v "^1\{32\}$" | grep -v "^ComputeBudget" |
  sort | uniq | sed 's/^/https:\/\/solscan.io\/account\//' >>txs

#base_url="https://app.cielo.finance/profile/ADDRESS_PLACEHOLDER/pnl/tokens?sortBy=pnl_desc"

grep -oP '(?<="accountKeys":\[)[^\]]*' getTranOut |
  tr -d '"' | tr ',' '\n' | grep -v "$BAITER_WALLET" | grep -v "^1\{32\}$" | grep -v "^ComputeBudget" |
  sort | uniq | while read -r address; do
  echo "https://app.cielo.finance/profile/$address/pnl/tokens?sortBy=pnl_desc"
done >>txs

#final_url=${base_url//ADDRESS_PLACEHOLDER/$address}

#echo "$final_url" >>txs

#grep -oP '(?<="accountKeys":\[)[^\]]*' getTranOut |
#  tr -d '"' | tr ',' '\n' | grep -v "$BAITER_WALLET" | grep -v "^1\{32\}$" | grep -v "^ComputeBudget" |
#  sort | uniq | sed 's/^/https:\/\/app.cielo.finance\/profile\/' >>txs

# Extract and label the programId, remove duplicates
#echo "Program IDs:"
#grep -oP '(?<="programId":")[^"]*' getTranOut |
#  sort | uniq | sed 's/^/programId: /' >>txs

# Extract and label the preTokenBalances, and fix formatting
#echo "Pre Token Balances:"
#grep -oP '(?<="preTokenBalances":\[)[^\]]*' getTranOut |
#  tr -d '"' | tr ',' '\n' | grep -v "^1\{32\}$" |
#  sort | uniq | sed 's/^/preTokenBalances: /' | sed -e 's/{/\n{/g' -e 's/}}/\n/g' >>txs

# Extract and label the postTokenBalances, and fix formatting
#echo "Post Token Balances:"
#grep -oP '(?<="postTokenBalances":\[)[^\]]*' getTranOut |
#  tr -d '"' | tr ',' '\n' | grep -v "^1\{32\}$" |
#  sort | uniq | sed 's/^/postTokenBalances: /' | sed -e 's/{/\n{/g' -e 's/}}/\n/g' >>txs

# Extract and label the instructions parameter and format
#echo "Instructions:"
#grep -oP '(?<="instructions":\[)[^\]]*' getTranOut |
#  tr -d '"' | tr ',' '\n' | sort | uniq | sed 's/^/instructions: /' | sed -e 's/{/\n{/g' >>txs
