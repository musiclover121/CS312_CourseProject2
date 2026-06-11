#!/bin/bash

set -euo pipefail

cleanup() {
	echo "Exiting due to error or interruption"
	exit 1
}

SKIP_SETUP=false
KEYPAIR_NAME="Error"

for arg in "$@"; do
  case "$arg" in
    --skip-setup)
      SKIP_SETUP=true
      ;;
    key=*)
      KEYPAIR_NAME=${arg#key=}
  esac
done

cd terraform

if [[ "$SKIP_SETUP" == false ]]; then
sudo apt install -y gnupg software-properties-common curl

curl -fsSL https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install terraform -y
sudo apt install awscli -y
sudo apt install nmap -y

aws --version
aws configure

mkdir diagrams

else
sudo apt update

fi

echo "key_name = \"$KEYPAIR_NAME\"" > terraform.tfvars

echo "Nmap Version: "
nmap --version
echo "Terraform Version: "
terraform -version
echo "AWS Version: "
aws --version

terraform init
terraform validate
terraform plan
terraform apply

echo "Sleeping for 30 seconds before running Nmap to test connection. Enter ctrl-c to skip."

sleep 30

nmap -sV -Pn -p T:25565 "$(terraform output -raw public_ip)"

echo "To skip downloads and configuration in the future, use the --skip-setup flag."

echo "Minecraft Server IP: "
terraform output
