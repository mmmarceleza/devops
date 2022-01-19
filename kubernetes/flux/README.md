# Flux


## Installation

You can download the binary on the [GitHub release page](https://github.com/fluxcd/flux2/releases) or use the following script:

```
curl -s https://fluxcd.io/install.sh | sudo bash
```

Check the installation:

```
flux -v
```

## Examples

### 00 - Basic installation and components

- Create a basic cluster with [kind](../kind/README.md).

```
flux check --pre
```

- Install flux:

```
flux install
```

- Check the new objects created:

```
flux version
kubectl get pod -A | grep flux
kubectl api-resources | grep fluxcd
```

- Remove Flux components:

```console
flux uninstall
```

### 01 - Bootstrap with GitHub

- Create a basic cluster with [kind](../kind/README.md).

- With `flux bootstrap` command you can install flux and configure it to manage itself from a git repository. If Flux was previously installed, it will be upgrade if needed. The bootstrap is idempotent, it’s safe to run the command as many times as you want. 

```
flux bootstrap github \
  --owner=mmmarceleza \
  --repository=devops \
  --path=kubernetes/flux/examples/01 \
  --interval=1m \
  --personal
```
note: change the `--owner` parameter to match your user.

- Check all the changes in your repository on GitHub:
  - commits;
  - deploy keys on settings;
  - new files created on the path you specified before;







Teste de pré-requisitos: flux check --pre

flux bootstrap github \
  --owner=<seu_usuario_github> \
  --repository=<nome_do_repositorio> \
  --path=clusters/my-cluster \
  --personal

Subir o app1 na raiz da pasta my-cluster

Criar a pasta apps na raiz de my-cluster e subir o app1 com o nome de app2

Subir o podinfo

flux create source git podinfo \
  --url=https://github.com/stefanprodan/podinfo \
  --branch=master \
  --interval=30s \
  --export > ./clusters/my-cluster/podinfo-source.yaml
  
git add -A && git commit -m "Add podinfo GitRepository"
git push


flux create kustomization podinfo \
  --target-namespace=default \
  --source=podinfo \
  --path="./kustomize" \
  --prune=true \
  --interval=5m \
  --export > ./clusters/my-cluster/podinfo-kustomization.yaml
  
git add -A && git commit -m "Add podinfo Kustomization"
git push


Customizar o podinfo alterando o podinfo-kustomization.yaml

patches:
    - patch: |-
        apiVersion: autoscaling/v2beta2
        kind: HorizontalPodAutoscaler
        metadata:
          name: podinfo
        spec:
          minReplicas: 3             
      target:
        name: podinfo
        kind: HorizontalPodAutoscaler
        
        
bootstrap com pods de image        

flux bootstrap github \
  --components-extra=image-reflector-controller,image-automation-controller \
  --owner=mmmarceleza \
  --repository=testekind \
  --path=clusters/my-cluster \
  --personal
