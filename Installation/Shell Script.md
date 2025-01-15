```bash
#!/bin/bash

# Variables for Azure DevOps Configuration
# Replace with your Azure DevOps organization URL and your generated PAT
AZDO_URL="https://dev.azure.com/krishn012025/"  # Replace {organization} with your Azure DevOps organization URL
PAT="7THLIQSlr7IxoP5maHl1rAM8Qs4fNSmi6MLJvhYaNWDkZVqUtCJQQJ99BAACAAAAAAAAOuS2t"  # Replace this with your generated PAT (Full access)

# Define the agent name and the pool name where the agent should be registered
AGENT_NAME="ProdAgentVM2"         # Specify the Agent Name
AGENT_POOL="LinuxHostedPool"      # Specify your custom agent pool name here

# Step 1: Update and upgrade the system
echo "Updating and upgrading the system packages..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Step 2: Install necessary tools
echo "Installing required tools (curl, tar, wget, unzip)..."
sudo apt install -y curl tar wget unzip

# Step 3: Create a directory for the agent and set the hostname
echo "Creating directory for the agent and setting hostname to $AGENT_NAME..."
mkdir -p /usr/local/bin/AzureDevOps-myagent
cd /usr/local/bin/AzureDevOps-myagent
hostnamectl set-hostname $AGENT_NAME

# Step 4: Download the Azure DevOps agent package
echo "Downloading the Azure DevOps agent package..."
wget https://vstsagentpackage.azureedge.net/agent/4.248.0/vsts-agent-linux-x64-4.248.0.tar.gz

# Step 5: Check if the download was successful before extracting
if [ -f vsts-agent-linux-x64-4.248.0.tar.gz ]; then
    echo "Download successful, extracting the agent package..."
    tar zxvf vsts-agent-linux-x64-4.248.0.tar.gz
else
    echo "Download failed or file not found." > /var/log/user-data.log
    exit 1
fi

# Step 6: Configure the agent using the provided Azure DevOps URL, PAT, and agent pool
echo "Configuring the Azure DevOps agent..."
./config.sh --unattended \
            --url $AZDO_URL \
            --auth pat \
            --token $PAT \
            --pool $AGENT_POOL \
            --agent $AGENT_NAME

# Step 7: Install and start the agent service
echo "Installing the agent service..."
sudo ./svc.sh install

echo "Starting the agent service..."
sudo ./svc.sh start

# Final message indicating successful setup
echo "Azure DevOps agent '$AGENT_NAME' has been successfully configured and is running in the '$AGENT_POOL' pool."
```
