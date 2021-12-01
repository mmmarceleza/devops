# MetalLB

## Preparation
- Edit the kube-proxy configmap:
```
kubectl edit configmap -n kube-system kube-proxy
```
- Enable strict ARP mode:
```
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: "ipvs"
ipvs:
  strictARP: true
```
## Installation By Manifest

To install MetalLB, apply the manifest:
```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/metallb.yaml
```
The installation manifest does not include a configuration file. MetalLB’s components will still start, but will remain idle until you define and deploy a configmap.
## Installation With Helm
- Install the Helm chart repository:
```
helm repo add metallb https://metallb.github.io/metallb
```
- Install with a personalized values file:
```
helm upgrade --install metallb metallb/metallb \
  --create-namespace \
  --namespace metallb-system \
  -f values
```
Remember to change the range ip in the values file.