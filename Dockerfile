# FROM node:lts as dependencies
# WORKDIR /app
# COPY package.json yarn.lock ./
# RUN yarn install --frozen-lockfile

# FROM node:lts as builder
# WORKDIR /app
# COPY . .
# COPY --from=dependencies /app/node_modules ./node_modules
# ENV NODE_OPTIONS --openssl-legacy-provider
# RUN yarn build

# FROM node:lts as runner
# WORKDIR /app
# ENV NODE_OPTIONS --openssl-legacy-provider
# ENV NODE_ENV production
# COPY --from=builder /app/node_modules ./node_modules
# COPY --from=builder /app/package.json ./package.json
# RUN mkdir src
# COPY ./examples/src/ /app/src
# RUN apt-get install gcc
# EXPOSE 3000
# LABEL org.opencontainers.image.source https://github.com/ab-inbev-maz/lh-maz-pop
# CMD ["yarn", "start"]

# Fetching the latest node image on alpine linux
# FROM node:latest AS development

# # Declaring env
# ENV NODE_ENV development

# # Setting up the work directory
# WORKDIR /react-app

# # Installing dependencies
# COPY ./package.json /react-app

# # Copying all the files in our project
# RUN mkdir src
# COPY examples/src src/

# RUN yarn install
# RUN yarn build

# # Starting our application
# CMD yarn develop

# pull official base image
# FROM node:13.12.0-alpine

# # set working directory
# WORKDIR /app

# # add `/app/node_modules/.bin` to $PATH
# ENV PATH /app/node_modules/.bin:$PATH

# # install app dependencies
# COPY package.json ./
# RUN npm install
# RUN npm install react-scripts@3.4.1 -g

# # add app
# COPY . ./

# # start app
# CMD ["npm", "start"]



# # ==== CONFIGURE =====
# # Use a Node 16 base image
# FROM node:16-alpine 
# # Set the working directory to /app inside the container
# WORKDIR /app
# # Copy app files
# COPY . .
# # ==== BUILD =====
# # Install dependencies (npm ci makes sure the exact versions in the lockfile gets installed)
# RUN npm ci 
# # Build the app
# RUN npm run build
# # ==== RUN =======
# # Set the env to "production"
# ENV NODE_ENV production
# # Expose the port on which the app will be running (3000 is the default that `serve` uses)
# EXPOSE 3000
# # Start the app
# CMD [ "npx", "serve", "build" ]

# FROM node:8.16 as build-deps
# WORKDIR /usr/src/app
# COPY package.json yarn.lock ./
# RUN yarn
# COPY . ./
# RUN yarn build

# FROM nginx:1.12-alpine
# COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
# EXPOSE 3001
# CMD ["nginx", "-g", "daemon off;"]


FROM node:18.13.0

ENV NODE_ENV development
ENV NODE_OPTIONS --openssl-legacy-provider

WORKDIR /usr/src/app
COPY . .

RUN yarn
RUN yarn build

EXPOSE 3000


CMD ["yarn", "start"]