# Multi Stage Building

Clone de repository:

```
git clone https://github.com/mmmarceleza/devops.git
```

Go to the correct folder:

```
cd devops/docker/examples/02/my-app
```

Run the following command to build the image:

```
docker build -t my-app:latest .
```

Run the container using the image:

```
docker run -d --rm -p 8080:80 my-app:latest
```

Compare the image size built with example 01
