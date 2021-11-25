# HAProxy

# Use HAProxy with Docker

## Using your own image

Create a Dockerfile:
```
FROM haproxy:2.3
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
```
Build the container:
```
$ docker build -t my-haproxy .
```
Test the configuration file
```
$ docker run -it --rm --name haproxy-syntax-check my-haproxy haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg
```
Run the container:
```
$ docker run -d --name my-running-haproxy --sysctl net.ipv4.ip_unprivileged_port_start=0 my-haproxy
```

## Directly via bind mount

```
$ docker run -d --name my-running-haproxy -v /path/to/etc/haproxy:/usr/local/etc/haproxy:ro --sysctl net.ipv4.ip_unprivileged_port_start=0 haproxy:2.3
```
Reloading config:
```
$ docker kill -s HUP my-running-haproxy
```
