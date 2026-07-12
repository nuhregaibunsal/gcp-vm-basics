#!/usr/bin/env bash
#
# Verify network connectivity to the cloud VM by sending ICMP echo requests
# to its public IP from the local machine.
#
# Usage:
#   ./scripts/ping-test.sh            # uses VM_PUBLIC_IP from config.env
#   ./scripts/ping-test.sh 34.0.0.10  # or pass an IP explicitly
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../config.env"

TARGET_IP="${1:-${VM_PUBLIC_IP}}"

if [[ -z "${TARGET_IP}" ]]; then
  echo "No target IP. Set VM_PUBLIC_IP in config.env or pass one as an argument." >&2
  exit 1
fi

echo ">> Pinging cloud VM at ${TARGET_IP}"

# ping flags differ between Windows and Unix-like systems
if [[ "${OS:-}" == "Windows_NT" ]]; then
  ping -n 4 "${TARGET_IP}"
else
  ping -c 4 "${TARGET_IP}"
fi
