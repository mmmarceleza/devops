# JSONPATH Cheat Sheet

## List cpu capacity of all nodes:

```console
kubectl get nodes -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.capacity.cpu}{"\n"}{end}'
```

or

```console
kubectl get nodes -o=custom-columns=NODE:.metadata.name,CPU:.status.capacity.cpu
```

## List memory capacity of all nodes:

```console
kubectl get nodes -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.capacity.memory}{"\n"}{end}'
```

or

```console
kubectl get nodes -o=custom-columns=NODE:.metadata.name,MEMORY:.status.capacity.memory
```

## List Taints of all nodes:

```console
kubectl get nodes -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.taints}{"\n"}{end}'
```

or

```console
kubectl get nodes -o=custom-columns=NODE:.metadata.name,TAINTS:.spec.taints
```

## List images of all pods:

```console
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].image}{"\n"}{end}'
```

or

```console
kubectl get pods -o=custom-columns=PODS:.metadata.name,IMAGES:.spec.containers[*].image
```

## List roleRef of all clusterrolebinding:

```console
oc get clusterrolebinding -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.roleRef.name}{"\n"}{end}'
```

or

```console
kubectl get clusterrolebinding -o=custom-columns=CLUSTERROLEBINDING:.metadata.name,ROLEREF:.roleRef.name
```
## List pods resources:

```console
kubectl get pods -o=custom-columns=PODS:.metadata.name,NAMESPACE:.metadata.namespace,"REQUEST CPU:".spec.containers[*].resources.requests.cpu,"REQUEST MEM:".spec.containers[*].resources.requests.memory,"LIMITS CPU:".spec.containers[*].resources.limits.cpu,"LIMITS MEM:".spec.containers[*].resources.limits.memory
```
