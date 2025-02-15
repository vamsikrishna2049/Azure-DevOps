# **Azure DevOps Terraform Deployment Pipeline Documentation**

## **Overview**
This Azure DevOps pipeline automates the following tasks:

1. **Git Checkout**: Retrieves the Terraform code from Azure Repos.  
2. **Terraform Deployment**:  
   - Downloads secure variables (`uat.tfvars`) from **Azure Pipelines → Library → Secure Files**.  
   - Validates AWS credentials using a **secure connection** (by installing the AWS Toolkit from the Azure Marketplace and adding AWS IAM credentials).  

---

## **Prerequisites**
Before running the pipeline, ensure the following setup is complete:

1. **EC2 Instance** – A self-hosted agent running on AWS.  
2. **AWS CLI Installation** – Install and configure AWS CLI on the instance.  
3. **Terraform Installation** – Install Terraform on the instance.  
4. **Azure DevOps Agent (VSTS) Installation** – Install and run the agent as a **system daemon**.  
5. **S3 Bucket and DynamoDB Setup** – Create both using the **same name** for Terraform backend storage and state locking.  

---

## **Terraform Code Structure**
```
|- variables.tf       # Declares input variables
|- provider.tf        # Configures AWS provider
|- main.tf            # Defines infrastructure resources
```
- The `terraform.tfvars` file is **passed as a secure file** from **Azure Pipelines → Library → Secure Files**.  
- **Allow access** to this file in Azure Pipelines to enable Terraform execution.  

---

## **AWS Credentials Configuration**
1. **Add AWS Credentials in Azure DevOps:**  
   - Go to **Azure DevOps → Library → Variable Groups**.  
   - Create a new variable group labeled **"aws"**.  
   - Add the following variables:  
     - `AWS_ACCESS_KEY_ID`  
     - `AWS_SECRET_ACCESS_KEY`  
     - `AWS_REGION`  

2. **Enable Secure AWS Connection in Azure DevOps:**  
   - Install the **AWS Toolkit** from the **Azure DevOps Marketplace**.  
   - Navigate to **Azure DevOps → Project Settings → Service Connections → New Service Connection → AWS**.  
   - Provide the required AWS IAM credentials.  

