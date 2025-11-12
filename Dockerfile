# Use Node lightweight image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package.json (for npm dependencies)
COPY package*.json ./

# Install Parcel globally
RUN npm install -g parcel

# Copy all source files
COPY . .

# Build the website
RUN parcel build src/index.html --dist-dir dist

# Expose port for testing
EXPOSE 1234

# Start static server
CMD ["npx", "serve", "-s", "dist", "-l", "1234"]
