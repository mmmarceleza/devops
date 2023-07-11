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
alias git-show-alias='cat $HOME/.gitconfig'

# Commands inside docker containers:
alias redis-cli='docker run --rm --network=host redis:alpine redis-cli'

# Kubernetes aliases:

alias k3mtaint='kubectl get nodes -o=custom-columns="NODE:.metadata.name,TAINTS:.spec.taints"'
alias k3mimage='kubectl get pods -o=custom-columns="PODS:.metadata.name,IMAGES:.spec.containers[*].image"'
alias k3mpodresource='kubectl get pods -o=custom-columns="PODS:.metadata.name,NAMESPACE:.metadata.namespace,"REQUEST_CPU:".spec.containers[*].resources.requests.cpu,"REQUEST_MEM:".spec.containers[*].resources.requests.memory,"LIMITS_CPU:".spec.containers[*].resources.limits.cpu,"LIMITS_MEM:".spec.containers[*].resources.limits.memory"'
alias k3mnoderesource='kubectl get nodes -o=custom-columns="NODE:.metadata.name,CPU:.status.capacity.cpu,MEMORY:.status.capacity.memory"'
alias k3mlabelnode="kubectl get nodes -ojson | jq '.items[].metadata | .name,.labels'"
alias k3mev='kubectl get events --sort-by='{.metadata.creationTimestamp}' | grep -v Normal'
alias k3mevall='kubectl get events -A --sort-by='{.metadata.creationTimestamp}' | grep -v Normal'

# Kind aliases:

alias kcc='kind create cluster --image kindest/node:v1.21.12'
alias kdc='kind delete cluster'

# Flux aliases:
alias fgall='flux get all'
alias fghr='flux get helmrelease'
alias fgiall='flux get image all'
alias fgip='flux get image policy'
alias fgir='flux get image repository'
alias fgiu='flux get image update'
alias fgk='flux get kustomization'
alias fgsall='flux get source all'
alias fgsb='flux get source bucket'
alias fgsc='flux get source chart'
alias fgsg='flux get source git'
alias fgsh='flux get source helm'
alias frhr='flux reconcile helmrelease'
alias frir='flux reconcile image repository'
alias friu='flux reconcile image update'
alias frk='flux reconcile kustomization'
alias frsg='flux reconcile source git'
alias frsh='flux reconcile source helm'
alias frsgc='flux reconcile source git cluster'
alias frkc='flux reconcile kustomization cluster'

# Others:

export EDITOR=vim

# Powerline configuration

# # Powerline configuration
# if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
#   powerline-daemon -q
#   POWERLINE_BASH_CONTINUATION=1
#   POWERLINE_BASH_SELECT=1
#   source /usr/share/powerline/bindings/bash/powerline.sh
# fi

# Starship configuration

# eval "$(starship init bash)"
