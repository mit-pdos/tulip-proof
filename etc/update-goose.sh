#!/bin/bash

set -eu

if [ $# -ne 1 ]; then
  echo "Usage: $0 <tulip-path>" >&2
  echo "Example: $0 ../tulip" >&2
  exit 1
fi

CODE_PATH="$1"

if [ ! -d "$CODE_PATH" ]; then
  echo "Error: Directory '$CODE_PATH' does not exist" >&2
  exit 1
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$DIR/.."

go tool goose -out external/Goose -dir "$CODE_PATH" \
  ./backup \
  ./gcoord \
  ./index \
  ./message \
  ./params \
  ./paxos \
  ./quorum \
  ./replica \
  ./tulip \
  ./tuple \
  ./txn \
  ./txnlog \
  ./util
