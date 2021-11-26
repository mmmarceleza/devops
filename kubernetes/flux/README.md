# Flux

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
