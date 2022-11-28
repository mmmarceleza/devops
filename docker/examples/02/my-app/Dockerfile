################################################################################
#                                   STAGE 01
################################################################################

# pull the base image
FROM node:lts as builder

# set the working direction
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package*.json ./

RUN npm install

# add app
COPY . ./

RUN npm run build

################################################################################
#                                   STAGE 02
################################################################################

#pull the official nginx:stable base image
FROM nginx:stable

# Set working directory to nginx resources directory
WORKDIR /usr/share/nginx/html

# Remove default nginx static resources
RUN rm -rf ./*

# Copies static resources from builder stage
COPY --from=builder /app/build .

# Containers run nginx with global directives and daemon off
ENTRYPOINT ["nginx", "-g", "daemon off;"]
