# Use an official Node runtime as a base image for building the app
FROM node:14-alpine AS builder

# Set the working directory in the container
WORKDIR /usr/src/app/frontend

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install frontend dependencies
RUN npm install

# Copy the rest of the application files to the container
COPY . .

# Build the frontend app
RUN npm run build

# Use NGINX as a lightweight base image to serve the app
FROM nginx:alpine

# Copy the built app from the previous stage
COPY --from=builder /usr/src/app/frontend/build /usr/share/nginx/html

# Expose port 80 to the outside world (default for HTTP)
EXPOSE 80
