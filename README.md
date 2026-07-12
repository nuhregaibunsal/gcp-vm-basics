# i2i Academy — Introduction to Cloud

Provision a Linux virtual machine on **Google Cloud Platform (GCP)**, verify
network reachability with an **ICMP ping test**, connect to it over **SSH**, and
validate basic Linux file operations by creating and reading a text file on the
instance.

## Objective

1. Create a Compute Engine VM (Debian 12) on GCP.
2. Ping the VM's public IP from the local machine to confirm connectivity.
3. Connect to the VM over SSH.
4. Create `hello.txt` containing `Hello i2i Academy!` and print its contents.

## Repository layout

```
config.env.example      Template for project/zone/instance settings
scripts/
  provision-vm.sh       Create the VM and open ICMP + SSH firewall rules
  ping-test.sh          Ping the VM public IP from the local machine
  ssh-connect.sh        Open an SSH session to the VM via gcloud
  hello-task.sh         Runs on the VM: create hello.txt and read it back
hello.txt               The expected file content
```

## Prerequisites

- A GCP account with billing enabled (the free tier `e2-micro` is sufficient).
- The [gcloud CLI](https://cloud.google.com/sdk/docs/install) installed and
  authenticated: `gcloud auth login`.

## Usage

```bash
# 1. Configure your project-specific values
cp config.env.example config.env
#    edit config.env: PROJECT_ID, ZONE, INSTANCE_NAME, ...

# 2. Provision the VM and firewall rules, then copy the printed external IP
#    into VM_PUBLIC_IP in config.env
./scripts/provision-vm.sh

# 3. Ping the VM from your local machine
./scripts/ping-test.sh

# 4. Connect over SSH
./scripts/ssh-connect.sh

# 5. Inside the SSH session, create and read the file
./hello-task.sh
```

## Expected result

- `ping-test.sh` reports `0% packet loss`, confirming the VM is reachable.
- `hello-task.sh` prints `Hello i2i Academy!`, confirming the file was created
  and read successfully on the VM.

## Clean up

To avoid charges, delete the VM when finished:

```bash
gcloud compute instances delete "$INSTANCE_NAME" --zone="$ZONE"
```
