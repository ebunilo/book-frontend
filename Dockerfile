# Stage 1: Build the React app
FROM node:14 as build

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
FROM node:14

# Install 'serve' to serve static files
RUN npm install -g serve

# Copy the build files from the previous stage
COPY --from=build /usr/src/app/build /usr/src/app/build

# Set the working directory
WORKDIR /usr/src/app/build

# Serve the static files
CMD ["serve", "-s", "."]

# Expose port 5000
EXPOSE 5000
