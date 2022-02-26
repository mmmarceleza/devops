# Mongodb

## Useful commands

- Check replicatset status:

```console
rs.status()
```

- Connect to mongo inside the cluster

```console
kubectl run mongo -it --rm --image=mongo -- sh
mongo mongodb://mongo-0.mongo,mongo-1.mongo,mongo-2.mongo --eval 'rs.status()' | grep name
```

- Run mongo in Docker

```console
docker run -d -p 27017 -v data:/data/db mongo
```
## Useful links

https://github.com/mongodb/mongodb-kubernetes-operator
https://mongodb.github.io/helm-charts/
