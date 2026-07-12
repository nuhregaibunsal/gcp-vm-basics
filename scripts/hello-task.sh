#!/usr/bin/env bash
#
# Run this ON the cloud VM after connecting over SSH. It creates hello.txt
# with the required text and prints the file back to the terminal.
#
# Usage (inside the SSH session):
#   ./hello-task.sh
#
set -euo pipefail

FILE="hello.txt"
MESSAGE="Hello i2i Academy!"

echo ">> Writing '${MESSAGE}' to ${FILE}"
echo "${MESSAGE}" > "${FILE}"

echo ">> Reading ${FILE} back:"
cat "${FILE}"
