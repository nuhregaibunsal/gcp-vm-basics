#!/usr/bin/env bash
#
# Open an SSH session to the cloud VM through gcloud, which manages the SSH
# key pair and firewall access automatically.
#
# Usage:
#   ./scripts/ssh-connect.sh
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../config.env"

echo ">> Connecting to ${INSTANCE_NAME} (${ZONE}) over SSH"
gcloud compute ssh "${INSTANCE_NAME}" --zone="${ZONE}"
