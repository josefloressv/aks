# AKS
AKS

## A Cloud Guru Restrictions
https://help.pluralsight.com/hc/en-us/articles/24392988447636-Azure-cloud-sandbox

* Virtual Machines
  * Allowed SKUs:
    * Standard A0 or A1 v2
    * Standard B1ms, B1s, B2ms, B2s
    * Standard D1 v2, DS1 v2
    * Standard D2, DS1
    * Standard D2s v3, DS3 v2
    * Standard F2
  * Max 10 instances total
  * Max 10 CPUs across all instances
  * Max 14 GB memory in a single instances
* Virtual Machine Scale Sets	
  * Max two scale sets
  * Max three instances per scale sets
* Azure Kubernetes Service (AKS)
  * Max three clusters
  * Max three nodes per cluster
  * Cannot view or manage the secondary resource group created as part of AKS setup
* Container Registry
  * Max one registry
* Resource groups
  * does not include the option to create additional resource groups that the provisioned by default

### Create a Kubernetes Cluster

Basic
* Cluster preset configuration: dev/test
* Region: East US
* AZ: 1,2
* Kubernetes Version: 1.30.6
* Node security channel type: None
* Authentication and Authorization: Local Account with Kubernetes RBAC

Node Pools
* agentpool
  * Mode: System (for system pods)
  * OS: Linux
  * AZ: 1,2
  * Node Size:
    * Standard D2s V3
      * 2 vCPU and 8 GiB memory
  * Scale Method: Autoscale
  * Min node count: 1
  * Max node count: 2
  * Max pod per node: 110
* userpool
  * Mode: user (for my pods)
  * OS: Linux
  * AZ: 1,2
  * Node Size:
    * Standard D2s V3
      * 2 vCPU and 8 GiB memory
  * Scale Method: Autoscale
  * Min node count: 1
  * Max node count: 2
  * Max pod per node: 110

Networking
* Container networking
  * Network configuration: Azure CNI overlay (Assing Pod IP address from Private Ip Space)
  * DNS name prefix: demo01-dns (DNS name prefix to use with the hosted Kubernetes API server FQDN. You will use this to connect to the Kubernetes API when managing containers after creating the cluster.)
  * Network policy: None
  * Load Balancer: Standard

Security
* OpenID Connect (OIDC): marked
* Image Cleaner: marked (to automatically delete stale, unreferenced images from your AKS clusters to improve security and performance)

## Azure CLI Commands

```bash
# Login with Azure
az login

# Use this for ACG or When using Incognito Windows
az login --use-device-code

# Logout
az logout

# Show account info
az account show

# Configure the Resource Group by default
az group list -o table
az configure --defaults group=1-22e5f5c3-playground-sandbox

# List AKS clusters
az aks list -o table

# Create AKS Cluster
az aks create \
  --name mycluster \
  --node-vm-size Standard_D2s_v3 \
  --node-count 1 \
  --enable-cluster-autoscaler \
  --min-count 1 \
  --max-count 2 \
  --generate-ssh-keys \
  --verbose

# Connect kubectl to an AKS cluster
az aks get-credentials --name mycluster

# Remove toleration when use Sytem node pool
kubectl taint nodes <NodeName> CriticalAddonsOnly:NoSchedule-

# Delete cluster
az aks delete --name mycluster --verbose
```

Kubernetes

```bash
# deploy a pod
k run nginx --image=nginx

# Create a Deployment
k create deployment nginx --image=nginx --replicas=2

# Expose the deployment to internet
k expose deployment nginx --type=LoadBalancer --port=80 --target-port=80 --name=nginxlb

# Deploy a dotnet application
k create deployment dotnet --image=josefloressv/dotnet:v1 --replicas=2
k expose deployment dotnet --type=LoadBalancer --port=80 --target-port=8080 --name=dotnetlb


# Scale a deployment and check AKS Autoscaling
k scale deployment/dotnet --replicas=30

# Count pods in per node
kubectl get pods -o wide --no-headers | awk '{print $7}' | sort | uniq -c
```