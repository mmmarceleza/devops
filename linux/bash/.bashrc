#------------------------------------------------------------------------------# 
#                __  __                    _               _                   #
#               |  \/  | __ _ _ __ ___ ___| | ___ ______ _( )___               #
#               | |\/| |/ _` | '__/ __/ _ \ |/ _ \_  / _` |// __|              #
#               | |  | | (_| | | | (_|  __/ |  __// / (_| | \__ \              #
#               |_|  |_|\__,_|_|  \___\___|_|\___/___\__,_| |___/              #
#                                                                              #
#                  _               _                                           #
#                 | |__   __ _ ___| |__  _ __ ___                              #
#                 | '_ \ / _` / __| '_ \| '__/ __|                             #
#                _| |_) | (_| \__ \ | | | | | (__                              #
#               (_)_.__/ \__,_|___/_| |_|_|  \___|                             #
#------------------------------------------------------------------------------# 


# Commom commands simplifications:

alias l='ls -lah'
alias g='git'

# Commands inside docker containers:
alias redis-cli='docker run --rm --network=host redis:alpine redis-cli'

# Kubernetes aliases:

alias k3mtaint='kubectl get nodes -o=custom-columns=NODE:.metadata.name,TAINTS:.spec.taints'
alias k3mimage='kubectl get pods -o=custom-columns=PODS:.metadata.name,IMAGES:.spec.containers[*].image'
alias k3mpodresource='kubectl get pods -o=custom-columns=PODS:.metadata.name,NAMESPACE:.metadata.namespace,"REQUEST_CPU:".spec.containers[*].resources.requests.cpu,"REQUEST_MEM:".spec.containers[*].resources.requests.memory,"LIMITS_CPU:".spec.containers[*].resources.limits.cpu,"LIMITS_MEM:".spec.containers[*].resources.limits.memory'
alias k3mnoderesource='kubectl get nodes -o=custom-columns=NODE:.metadata.name,CPU:.status.capacity.cpu,MEMORY:.status.capacity.memory'
alias k3mlabelnode="kubectl get nodes -ojson | jq '.items[].metadata | .name,.labels'"

# Kind aliases:

alias kcc='kind create cluster --image kindest/node:v1.21.12'
alias kdc='kind delete cluster'

# Others:

export EDITOR=vim

