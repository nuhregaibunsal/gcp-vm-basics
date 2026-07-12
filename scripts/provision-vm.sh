#!/usr/bin/env bash
#
# Provision a Compute Engine VM on Google Cloud Platform and open ICMP + SSH
# so the instance can be reached by the ping test and over SSH.
#
# Usage:
#   ./scripts/provision-vm.sh
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../config.env"

echo ">> Setting active project to ${PROJECT_ID}"
gcloud config set project "${PROJECT_ID}"

echo ">> Creating VM '${INSTANCE_NAME}' in ${ZONE}"
gcloud compute instances create "${INSTANCE_NAME}" \
  --zone="${ZONE}" \
  --machine-type="${MACHINE_TYPE}" \
  --image-family="${IMAGE_FAMILY}" \
  --image-project="${IMAGE_PROJECT}" \
  --tags=allow-icmp,allow-ssh

echo ">> Allowing inbound ICMP so the VM answers ping"
gcloud compute firewall-rules create allow-icmp \
  --allow=icmp \
  --target-tags=allow-icmp \
  --description="Allow ping to the course VM" \
  || echo "   firewall rule 'allow-icmp' already exists, skipping"

echo ">> Allowing inbound SSH (tcp/22)"
gcloud compute firewall-rules create allow-ssh \
  --allow=tcp:22 \
  --target-tags=allow-ssh \
  --description="Allow SSH to the course VM" \
  || echo "   firewall rule 'allow-ssh' already exists, skipping"

echo ">> VM details"
gcloud compute instances describe "${INSTANCE_NAME}" \
  --zone="${ZONE}" \
  --format="value(name, networkInterfaces[0].accessConfigs[0].natIP)"

echo ">> Done. Copy the external IP above into VM_PUBLIC_IP in config.env"
