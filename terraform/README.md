# How to Run
1. Configure Azure Service Principal credentials and Default Resource Group in .auto.tfvars
2. Deploy with Terraform commands
```bash
terraform init
terraform plan
terraform apply
```
3. Connect to the AKS cluster
```bash
# List Azure Resource Groups
az group list -o table

# Configure by default Azure RG
az configure --defaults group=1-9a8e4d77-playground-sandbox

# List the AKS cluster
az aks list -o table

# Connect to the AKS cluster
az aks get-credentials --name guru-aks
```