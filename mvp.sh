BAITERWALLET=$1

if [ ! -d "run" ]; then
  echo "No run dir.. Creating!"
  mkdir run
else
  echo "Old run found... Deleting and recreating!"
  rm -rf run/
  mkdir run
fi

cd run

JSON_PAYLOAD=$(
  cat <<EOF
  {
    "jsonrpc": "2.0",
    "id": 1,
    "method": "getSignaturesForAddress",
    "params": [
        "$BAITERWALLET",
        {
          "limit": 1000
        }
    ]
  }
EOF
)

URL="https://api.mainnet-beta.solana.com"

curl "$URL" -X POST \
  -H "Content-Type: application/json" \
  -d "$JSON_PAYLOAD" >>curlOut

grep -o '"signature":"[^"]*"' curlOut | cut -d':' -f2 | tr -d '"' >>grepOut

sh ../getTransaction.sh
#sh ../filterGetTxOutNew.sh
sh ../filterfor50.sh

cd ..

#while read -r grepOut; do
#  if [ -n "$grepOut" ]; then
#    JSON_PAYLOAD=$(
#      cat <<EOF
#    {
#      "jsonrpc": "2.0",
#      "id":1,
#      "method":"getTransaction",
#      "params":
#        [
#          "$grepOut",
#          "json"
#        ]
#    }
#EOF
#    )
#
#    echo "Fetching tx for sig: $grepOut"
#    curl "$URL" -X POST \
#      -H "Content-Type: application/json" \
#      -d "$JSON_PAYLOAD" \
#      --fail || echo "Failed to fetch tx for $grepOut"
#
#    sleep 1
#  fi

#done
#  curl https://api.mainnet-beta.solana.com -X POST -H "Content-Type: application/json" -d
#  '
