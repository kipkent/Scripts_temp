#env
$NAME_AKS="alex-test3"
$LOCATION="westeurope"
$NAME_RGROUP_AKS="$NAME_AKS-rg"
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

# connect to aks
az aks get-credentials -g $NAME_RGROUP_AKS -n $NAME_AKS --overwrite-existing
#test --namespace my-app
kubectl run hello --generator=run-pod/v1 --image=nginx:latest --port=80 --labels="aadpodidbinding=$POD_IDENTITY_NAME" --namespace my-app
kubectl exec hello -it --namespace my-app bash
#test --namespace default
kubectl run hello --generator=run-pod/v1 --image=nginx:latest --port=80 --labels="aadpodidbinding=$POD_IDENTITY_NAME"
kubectl get pods --all-namespaces
kubectl exec hello -it bash
#test token generation in pod
apt update;apt install jq -y
curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true
curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fdatabase.windows.net%2F' -H Metadata:true
exit
kubectl delete pod hello
# other commands
kubectl get pods --all-namespaces
kubectl get pods --all-namespaces --show-labels
kubectl delete pod hello --namespace=my-app

kubectl get AzureIdentity --all-namespaces -o yaml
kubectl get AzureIdentityBinding --all-namespaces -o yaml
