# Sops

## Creating gpg keys

Prerequisites:

- gnupg
- [sops](https://github.com/mozilla/sops/releases)

Create a variable with the key name:

```console
export KEY_NAME="dev.marceleza.com"
```

Create a variable with a comment to identify the key:

```console
export KEY_COMMENT="flux secrets"
```

Key generating:

```console
gpg --batch --full-generate-key <<EOF
%no-protection
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Expire-Date: 0
Name-Comment: ${KEY_COMMENT}
Name-Real: ${KEY_NAME}
EOF
```

List the key to see the fingerprint:

```console
gpg --list-secret-keys "${KEY_NAME}"
```

Create a variable with the fingerprint from the last step:

```console
export KEY_FP=<paste it here>
```

Command to see the private key:

```console
gpg --export-secret-keys --armor "${KEY_FP}"
```

Command to see the public key:

```console
gpg --export --armor "${KEY_FP}"
```

## Flux configuration to use sops

Create a secret with GPG keys:

```console
gpg --export-secret-keys --armor "${KEY_FP}" |
kubectl create secret generic sops-gpg \
--namespace=flux-system \
--from-file=sops.asc=/dev/stdin
```

Add sops parameters in the desired kustomization:

```console
spec:
  decryption:
    provider: sops
    secretRef:
      name: sops-gpg
```

Optionally, the public key should be sent to the repository, in case the team wants to encrypt some files:
The following paths are related to the root of the repository.

```console
gpg --export --armor "${KEY_FP}" > ./kubernetes/sops/.sops.pub.asc
```

To import the public key, use the following command:

```console
gpg --import ./kubernetes/sops/.sops.pub.asc
```

The next step is creating a sops configuration file:

```console
cat <<EOF > ./kubernetes/sops/.sops.yaml
creation_rules:
  - path_regex: .*.yaml
    encrypted_regex: ^(data|stringData)$
    pgp: ${KEY_FP}
EOF
```

## Basic test with sops

- Create a basic cluster with [kind](../kind/README.md);

- Bootstrap a github repository with [Flux](../flux/README.md);

```console
flux bootstrap github \
  --owner=mmmarceleza \
  --repository=devops \
  --path=kubernetes/sops \
  --interval=1m \
  --personal
```

Create a simple secret to test:

```console
kubectl -n default create secret generic basic-auth \
--from-literal=user=admin \
--from-literal=password=change-me \
--dry-run=client \
-o yaml > ./kubernetes/sops/basic-auth.yaml
```

Encrypt that secret using sops:

```console
sops --encrypt --in-place --config=./kubernetes/sops/.sops.yaml ./kubernetes/sops/basic-auth.yaml
```

Commit this new secret manifest to your repository:

```console
git add ./kubernetes/sops/basic-auth.yaml
git commit -m "adding new secret to test sops"
git push
```

Wait Flux reconciliation and take a look in the cluster if it is there.


