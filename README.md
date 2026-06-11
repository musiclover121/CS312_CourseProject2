# Automated Minecraft Server

## Background
This Repository will create a Minecraft server on an AWS EC2 instance, using the command line. You will use Terraform and the AWS CLI to create and maintain the server.

## Technologies Used
- Terraform
- AWS EC2
- AWS CLI
- Ubuntu Server
- Bash scripting
- systemd

## Requirements
- AWS Academy account
- AWS CLI
- Terraform
- Ubuntu terminal

## Repository Structure
The repository contains:
- all the files needed to setup the server
  - main.tf
  - outputs.tf
  - provider.tf
  - variables.tf
  - terraform.tfvars
- the script that is added to the server to setup and run Minecraft on it
  - ./terraform/setup.sh
- the script that can be run by a server administrator to update necessary services (Terraform and AWS) and setup the server.
  - ./Create_Server.sh

## Environment Setup
- Download the files in this repository. (Unzip if needed)
- Run the `Create_Server.sh` bash script to download the Nmap, Terraform, and AWS services.
  ```bash
  Bash Create_Server.sh key="[YOUR_KEYPAIR_NAME]"
  ```
  If you already have Nmap, Terraform, and AWS services download and set up, use the `--skip-setup` argument to skip downloads and credential setup.
  - Grab your AWS credentials from the Learner's Lab. It will ask for these values:
    - AWS Access Key ID: `[YOUR_ACCESS_KEY_ID]`
    - AWS Secret Access Key: `[YOUR_SECRET_ACCESS_KEY]`
    - AWS Session Token: `[YOUR_SESSION_TOKEN]`
    - Default region: `[YOUR_DEFAULT_REGION]`
    - Default output format: `JSON`
  - The script will then run the Terraform commands to create a new server.
    - When asked if you want to apply the Terraform actions, type `yes` to start applying AWS resources based on the outlined plan. 
  - Finally, the script will verify the server is active with Nmap, and print the server's IP on completion.
      If you wish to skip the verification, enter `ctrl-c`

## Connecting to the Minecraft Server
- Open `Minecraft`
- Click `Multiplayer`
- Click `Add Server`
- Enter:  
  `[YOUR_SERVER_IP]:25565`
  (this will have been printed at the end of the "Create_Server.sh" script)
- Click `Join Server`    

## Destroying Infrastructure
- To destroy the server and all supporting infrastructure, use the command:
    ```bash
    terraform destroy
    ```

## Referances
* [Instructions for Key Pair Creation](https://canvas.oregonstate.edu/courses/2066853/assignments/10501907)
* [Minecraft Server Download](https://www.minecraft.net/en-us/download/server)
* [AWS Homepage](console.aws.amazon.com/console/home)
* [Bash Scripting - Cases](https://www.geeksforgeeks.org/linux-unix/bash-scripting-case-statement/)
* [AWS CLI Minecraft Server](https://blog.abstractlabs.co.uk/how-to-deploy-a-minecraft-server-on-aws-using-terraform-iac-b8691e87b55f)

