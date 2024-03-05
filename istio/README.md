########  install without operator   ########

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

helm install istio-base istio/base -n istio-system
helm install istiod istio/istio-control/istio-discovery -n istio-system
helm install istio-ingress istio/gateway -n istio-system
helm install istio-egress istio/gateway -n istio-system


 helm search repo istio --versions |grep gate
istio/gateway                      	1.20.3       	1.20.3     	Helm chart for deploying Istio gateways 

########  install with operator   ########

helm repo add stevehipwell https://stevehipwell.github.io/helm-charts/
helm repo update
helm install istio-operator stevehipwell/istio-operator --namespace istio-operator --create-namespace --version <desired_version>

 
 