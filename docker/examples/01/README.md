# React Native

## Without Docker

On a Ubuntu VM install nodejs LTS with the folowing commands:

```
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - && sudo apt-get install -y nodejs
```

Reference: https://github.com/nodesource/distributions/blob/master/README.md

Next, run some more commands to build and run your app:

```
npx create-react-app my-app
cd my-app
npm start
```

Finally, open your applicantion using your browser with this url: 

http://localhost:3000

## With Docker

On a Ubuntu VM with Docker installed, run the following command:

```
npx create-react-app my-app
```

Now, enter in the folder my-app and create your Dockerfile:

```
# pull the base image
FROM node:lts

# set the working direction
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package*.json ./

RUN npm install

# add app
COPY . ./

# start app
CMD ["npm", "start"]
```

Next, create a `.dockerignore` file:

```
node_modules
npm-debug.log
build
.dockerignore
**/.git
**/.DS_Store
**/node_modules
```

Now, build you image:

```
docker build -t my-app:dev .
```

Finally, run your application:

```
docker run -d -p 2222:3000 my-app:dev
```

