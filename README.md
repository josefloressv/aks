# AKS
AKS

## Azure CLI Commands

```bash
# Login & Logout with Azure
az login
az logout

# Show account info
az account show

# Configure default groups
az configure --defaults group=1-22e5f5c3-playground-sandbox

# List AKS clusters
az aks list -o table

# Connect kubectl to an AKS cluster
az aks get-credentials --name aks1-test

# Remove toleration when use Sytem node pool
kubectl taint nodes <NodeName> CriticalAddonsOnly:NoSchedule-

```