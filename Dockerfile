# Stage 1: Build the project
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install dependencies (includes parcel if listed in devDependencies)
RUN npm install

# Copy all project files
COPY . .

# Build the project (output goes to /app/dist)
RUN npx parcel build src/index.html --dist-dir dist

# Stage 2: Serve the built website
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install static server
RUN npm install -g serve

# Copy build output from the builder stage
COPY --from=builder /app/dist ./dist

# Expose the port
EXPOSE 1234

# Serve the static build
CMD ["serve", "-s", "dist", "-l", "1234"]
