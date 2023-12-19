#!/bin/bash

echo "[TASK 1] Pull required containers"
kubeadm config images pull >/dev/null 2>&1

echo "[TASK 2] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=172.16.16.100 --pod-network-cidr=192.168.0.0/16 >> /root/kubeinit.log 2>/dev/null

echo "[TASK 3] Deploy Calico network"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.3/manifests/calico.yaml >/dev/null 2>&1

echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh 2>/dev/null

echo "[TASK 5] Generate config file to use kubectl"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "[TASK 6] Enable aliases to use with kubectl"
curl -fsSLo /root/.bash_aliases https://raw.githubusercontent.com/ahmetb/kubectl-aliases/master/.kubectl_aliases
sed -ri 's/(kubectl.*) --watch/watch \1/g' /root/.bash_aliases

echo "[TASK 6] Install kubectx and kubens with command line fuzzy find"
apt install -qq -y git fzf >/dev/null 2>&1
git clone https://github.com/ahmetb/kubectx /opt/kubectx >/dev/null 2>&1
ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
ln -s /opt/kubectx/kubens /usr/local/bin/kubens

echo "[TASK 7] Install kube-ps1: Kubernetes prompt for bash"
git clone https://github.com/jonmosco/kube-ps1.git /root/.kube-ps1 >/dev/null 2>&1
chmod u+x /root/.kube-ps1/kube-ps1.sh
cat >>/root/.bashrc<<EOF

# kube-ps1
source '/root/.kube-ps1/kube-ps1.sh'
PS1="\033[0;31m\u\033[0m\033[1;33m@\033[0m\033[0;32m\w\033[0m\\\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\\\$(kube_ps1)\n# "
KUBE_PS1_SYMBOL_USE_IMG=true
EOF

echo "[TASK 7] Install krew"
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
) >/dev/null 2>&1
cat >>/root/.bashrc<<EOF

#kubectl krew
export PATH="\${KREW_ROOT:-\$HOME/.krew}/bin:\$PATH"
EOF

echo "[TASK 8] Install kubectl explore"
kubectl krew install explore >/dev/null 2>&1

echo "[TASK 9] install Flux"
curl -s https://fluxcd.io/install.sh | sudo bash >/dev/null 2>&1
cat >>/root/.bashrc<<EOF

#Flux autocompletion
. <(flux completion bash)
EOF

echo "[TASK 9] install Helm"
curl -s https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash >/dev/null 2>&1

echo "[TASK 10] Install kustomize"
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash >/dev/null 2>&1
mv kustomize /usr/local/bin
