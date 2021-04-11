#env
$NAME_AKS="example"
$LOCATION="example"
$NAME_RGROUP_AKS="$NAME_AKS-rg"
#$NAME_RGROUP_AKS="example"
$NODE_COUNT="1"
$CONTAINER_REG="example"
# networking
$NAME_RGROUP_VNET="example"
$NAME_VNET="example"
$NAME_SUBNET="example"
$VNET_ID=$(az network vnet show --resource-group $NAME_RGROUP_VNET --name $NAME_VNET --query id -o tsv)
$VNET_SUBNET_ID=$(az network vnet subnet show --resource-group $NAME_RGROUP_VNET --vnet-name $NAME_VNET --name $NAME_SUBNET --query id -o tsv)
# identity
$NAME_RGROUP_IDENTITY="$NAME_AKS-myIdentityResourceGroup"
$NAME_IDENTITY="$NAME_AKS-app-identity"
$POD_IDENTITY_NAME="my-pod-identity"
$POD_IDENTITY_NAMESPACE="default"

#1 greate group
az group create --name $NAME_RGROUP_AKS --location $LOCATION
#2 create aks
az aks create -g $NAME_RGROUP_AKS -n $NAME_AKS --load-balancer-sku standard --enable-managed-identity --enable-pod-identity --network-plugin azure --node-count $NODE_COUNT --generate-ssh-keys --service-cidr 10.0.0.0/16 --dns-service-ip 10.0.0.10 --docker-bridge-address 172.51.0.1/16 --vnet-subnet-id $VNET_SUBNET_ID --network-policy calico --attach-acr $CONTAINER_REG --enable-private-cluster --yes
#3 assignment role SERVICE PRINCIPAL with VNET
$SERVICE_PRINCIPAL_ID=$(az aks show -g $NAME_RGROUP_AKS -n $NAME_AKS --query identity.principalId -otsv)
az role assignment create --assignee $SERVICE_PRINCIPAL_ID --scope $VNET_ID --role Contributor
#4 connect to aks
az aks get-credentials -g $NAME_RGROUP_AKS -n $NAME_AKS --overwrite-existing
#5 create group identity
az group create --name $NAME_RGROUP_IDENTITY --location $LOCATION
#6 create identity
az identity create --resource-group $NAME_RGROUP_IDENTITY --name $NAME_IDENTITY
# env identity
$IDENTITY_CLIENT_ID=$(az identity show -g $NAME_RGROUP_IDENTITY -n $NAME_IDENTITY --query clientId -otsv)
$IDENTITY_RESOURCE_ID=$(az identity show -g $NAME_RGROUP_IDENTITY -n $NAME_IDENTITY --query id -otsv)
#7 add pod-identity to aks (we can add --namespace my-app)
az aks pod-identity add --resource-group $NAME_RGROUP_AKS --cluster-name $NAME_AKS --namespace $POD_IDENTITY_NAMESPACE  --name $POD_IDENTITY_NAME --identity-resource-id $IDENTITY_RESOURCE_ID

