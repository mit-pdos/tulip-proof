#!/bin/bash

set -eu

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$DIR/.."

TULIP_PATH=""
RSM_PATH=""

usage() {
  echo "Usage: $0 [--tulip <path>] [--rsm <path>]"
  echo ""
  echo "Options:"
  echo "  --tulip <path>   Path to mit-pdos/tulip repository"
  echo "  --rsm <path>      Path to mit-pdos/rsm repository"
}

# Check if no arguments provided
if [ $# -eq 0 ]; then
  usage
  exit 1
fi

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
  --tulip)
    TULIP_PATH="$2"
    shift 2
    ;;
  --rsm)
    RSM_PATH="$2"
    shift 2
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  *)
    echo "error: unexpected argument $1"
    usage
    exit 1
    ;;
  esac
done

# Verify at least one path was provided
if [ -z "$TULIP_PATH" ] && [ -z "$RSM_PATH" ]; then
  echo "Error: At least one repository path must be provided."
  usage
fi

if [ -n "$TULIP_PATH" ]; then
  go tool goose -out external/Goose -dir "$TULIP_PATH" \
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
fi

if [ -n "$RSM_PATH" ]; then
  go tool goose -out external/Goose -dir "$RSM_PATH" \
    ./spaxos \
    ./mpaxos \
    ./distx \
    ./tpl \
    ./pcr
fi
