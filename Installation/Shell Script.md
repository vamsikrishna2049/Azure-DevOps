```bash
#!/bin/bash

# Variables for Azure DevOps Configuration
organization_Name="krishn012025"  # Replace {organization} with your Azure DevOps organization URL
PAT="3zn4R8seGkBcnNzJIncybJEI8QnC6yDFPxXM9HS7VYIlJQQJ99BA"         # Use an environment variable to store the PAT for security

# Define the agent name and the pool name where the agent should be registered
AGENT_NAME="AgentVM"              # Specify the Agent Name
AGENT_POOL="LinuxHostedPool"      # Specify your custom agent pool name here

# Step 1: Update and upgrade the system
echo "Updating and upgrading the system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Step 2: Install necessary tools
echo "Installing required tools (curl, tar, wget, unzip)..."
sudo apt install -y curl tar wget unzip

# Step 3: Create a directory for the agent and set the hostname
echo "Creating directory for the agent and setting hostname to $AGENT_NAME..."
sudo mkdir -p /usr/local/bin/AzureDevOps-myagent
cd /usr/local/bin/AzureDevOps-myagent
sudo hostnamectl set-hostname $AGENT_NAME

# Step 4: Download the Azure DevOps agent package
echo "Downloading the Azure DevOps agent package..."
wget -q https://vstsagentpackage.azureedge.net/agent/4.248.0/vsts-agent-linux-x64-4.248.0.tar.gz

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Download successful, extracting the agent package..."
    tar zxvf vsts-agent-linux-x64-4.248.0.tar.gz
else
    echo "Download failed or file not found." | tee -a /var/log/user-data.log
    exit 1
fi

# Step 5: Configure the agent using the provided Azure DevOps URL, PAT, and agent pool
echo "Configuring the Azure DevOps agent..."
./config.sh --unattended \
            --url "https://dev.azure.com/$organization_Name" \
            --auth pat \
            --token $PAT \
            --pool $AGENT_POOL \
            --agent $AGENT_NAME

# Step 6: Install and start the agent service
echo "Installing the agent service..."
sudo ./svc.sh install

# Check if the service installation was successful
if [ $? -ne 0 ]; then
    echo "Failed to install agent service." | tee -a /var/log/user-data.log
    exit 1
fi

echo "Starting the agent service..."
sudo ./svc.sh start

# Start the agent service 
sudo systemctl start "vsts.agent.$organization_Name.$AGENT_POOL.$AGENT_NAME.service"

# Enable the agent service 
sudo systemctl enable "vsts.agent.$organization_Name.$AGENT_POOL.$AGENT_NAME.service"

# Check the agent service status
sudo systemctl status "vsts.agent.$organization_Name.$AGENT_POOL.$AGENT_NAME.service"

# Final message indicating successful setup
echo "Azure DevOps agent '$AGENT_NAME' has been successfully configured and is running in the '$AGENT_POOL' pool."

```
