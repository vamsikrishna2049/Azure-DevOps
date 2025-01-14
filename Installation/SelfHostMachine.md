Here’s a summarized step-by-step guide to installing and configuring the Azure DevOps agent on a Linux system

### 1. **Prepare the Environment**
   - Make sure you have an active Azure DevOps organization and project setup.
   - Ensure the Linux machine has internet access and the required dependencies are installed.

```bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y wget tar
```

### 2. **Download the Agent**
   - Download the Azure DevOps agent package (usually a `.tar.gz` file) from the official Microsoft repository.
   
   ```bash
   mkdir myagent
   cd myagent
   wget https://vstsagentpackage.azureedge.net/agent/4.248.0/vsts-agent-linux-x64-4.248.0.tar.gz
   ```

### 3. **Extract the Package**
   - Extract the downloaded `.tar.gz` file:
   
   ```bash
   tar -xzvf vsts-agent-linux-x64-4.248.0.tar.gz
   ```

### 4. **Configure the Agent**
   - Change to the extracted directory:
   
   ```bash
   cd vsts-agent-linux-x64-4.248.0
   ```

   - Run the configuration script and follow the prompts:
   
   ```bash
   ./config.sh
   ```

   During configuration, you will need:
   - Azure DevOps Server URL (e.g., `https://dev.azure.com/your-org`).
   - Personal Access Token (PAT) to authenticate.
   - The agent pool name (can be the default or a custom pool) - Custom pool Name.
   - The agent name (can use the default or specify a name) - Custom Agent Name.

### 5. **Install the Agent as a Service**
   - To install the agent as a service, use the following command:
   
   ```bash
   sudo ./svc.sh install
   ```

   This will install the agent as a systemd service and set it up to start automatically.

### 6. **Start the Service**
   - After installation, start the agent service:
   
   ```bash
   sudo ./svc.sh start
   ```

### 7. **Verify the Agent Status**
   - Check the agent status to confirm it is running:
   
   ```bash
   sudo systemctl status vsts.agent.<agent_name>.service
   ```

#### Ex:
sudo systemctl status vsts.agent.krishnap13012025.LinuxHostedPool.azuredevops.service

### 8. **Enable Agent Status**
   - Check the agent status to confirm it is running:
   
   ```bash
   sudo systemctl status vsts.agent.<agent_name>.service
   ```

#### Ex:
sudo systemctl enable vsts.agent.krishnap13012025.LinuxHostedPool.azuredevops.service

### 9. **Troubleshoot (if necessary)**
   - If there are any issues during installation, check the log files located in `/var/log/vsts-agent/` or `/var/cache/vsts-agent/` for troubleshooting.
   - You can also reset the agent's configuration or re-run the installation commands to replace or update the agent.

### 10. **Removing the Agent**
   - To uninstall the agent, you can stop the service, remove the agent files, and clean up systemd configuration:
   
   ```bash
   sudo systemctl stop vsts.agent.<agent_name>.service
   sudo systemctl disable vsts.agent.<agent_name>.service
   sudo rm -rf /home/ubuntu/agent
   sudo rm -rf /var/log/vsts-agent/
   sudo rm -rf /var/cache/vsts-agent/
   sudo systemctl daemon-reload
   ```

This summarizes the installation and setup of an Azure DevOps agent on a Linux machine.
