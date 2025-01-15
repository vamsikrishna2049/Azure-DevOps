#!/bin/bash

# Variables for Azure DevOps Configuration (Replace these with your actual values)
AZDO_URL="https://dev.azure.com/krishnap13012025/"   # Replace {organization} with your Azure DevOps organization URL
PAT="7THt"                  # Replace this with your generated PAT
AGENTName="ProdAgentVM2"        # Specify the Agent Name
AGENT_POOL="LinuxHostedPool"  # Specify your custom agent pool name here


# Update and upgrade the system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install necessary tools
sudo apt install -y curl tar wget unzip

# Create directory for the agent and change to it
mkdir -p /usr/local/bin/AzureDevOps-myagent
cd /usr/local/bin/AzureDevOps-myagent
hostnamectl set-hostname $AGENTName

# Download the agent package
wget https://vstsagentpackage.azureedge.net/agent/4.248.0/vsts-agent-linux-x64-4.248.0.tar.gz

# Check if the download was successful before extracting
if [ -f vsts-agent-linux-x64-4.248.0.tar.gz ]; then
    tar zxvf vsts-agent-linux-x64-4.248.0.tar.gz
else
    echo "Download failed or file not found" > /var/log/user-data.log
    exit 1
fi

# Configure the agent (this is where you specify the URL and PAT)
./config.sh --unattended --url $AZDO_URL --auth pat --token $PAT --pool $AGENT_POOL --agent $AGENT_NAME

# Start the agent service
sudo ./svc.sh install
sudo ./svc.sh start
