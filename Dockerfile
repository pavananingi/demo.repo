# Use Node.js image for building the app
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app's source code
COPY . .

# Build the app (if applicable, e.g., React/Angular/Vue apps)
RUN npm run build

# Use Nginx for serving the app
FROM nginx:1.21 AS production

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built app from the build stage
COPY --from=build /app/dist /usr/share/nginx/html
