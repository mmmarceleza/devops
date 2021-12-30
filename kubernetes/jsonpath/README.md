# JSONPATH Cheat Sheet

List cpu capacity of all nodes:

```
kubectl get nodes -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.capacity.cpu}{"\n"}{end}'
```

List memory capacity of all nodes:

```
kubectl get nodes -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.capacity.memory}{"\n"}{end}'
```

List Taints of all nodes:

```
kubectl get nodes -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.taints}{"\n"}{end}'
```

List images of all pods:

```
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].image}{"\n"}{end}'
```

List roleRef of all clusterrolebinding:

```
oc get clusterrolebinding -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.roleRef.name}{"\n"}{end}'
```
