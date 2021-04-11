#env
$NAME_AKS="example"
$LOCATION="westeurope"
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

#DELETE AKS, identity, groups
az aks delete -g $NAME_RGROUP_AKS -n $NAME_AKS --yes
az identity delete --resource-group $NAME_RGROUP_IDENTITY --name $NAME_IDENTITY
az group delete --name $NAME_RGROUP_AKS --yes
az group delete --name $NAME_RGROUP_IDENTITY --yes
