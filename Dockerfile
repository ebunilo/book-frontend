# Stage 1: Build the React app with Vite
FROM node:18 AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the React app with a static file server
FROM node:18

# Install 'serve' to serve static files
RUN npm install -g serve

# Copy the build files from the previous stage
COPY --from=build /usr/src/app/dist /usr/src/app/dist

# Set the working directory
WORKDIR /usr/src/app/dist

# Serve the static files
CMD ["serve", "-s", "."]

# Expose port 5000
EXPOSE 5000
