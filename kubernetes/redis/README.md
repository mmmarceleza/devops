# Redis

- Redis can be accessed on the following DNS names from within your cluster:

redis-master.redis.svc.cluster.local for read/write operations (port 6379)
redis-replicas.redis.svc.cluster.local for read-only operations (port 6379)

- To get your password run:

export REDIS_PASSWORD=$(kubectl get secret --namespace redis redis -o jsonpath="{.data.redis-password}" | base64 --decode)

- To connect to your Redis server:

1. Run a Redis pod that you can use as a client:

kubectl run --namespace redis redis-client --restart='Never' --env REDIS_PASSWORD=$REDIS_PASSWORD --image docker.io/bitnami/redis:6.2.6-debian-10-r139 --command -- sleep infinity

Use the following command to attach to the pod:

kubectl exec --tty -i redis-client \
--namespace redis -- bash

2. Connect using the Redis CLI:
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-master
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-replicas

To connect to your database from outside the cluster execute the following commands:

kubectl port-forward --namespace redis svc/redis-master : &
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p

- Alias for .bashrc

alias redis-cli='docker run --rm --network=host redis:alpine redis-cli'
