# === Stage 1: Build the Node.js application ===
FROM node:latest as builder

WORKDIR /app

# Copy the application code and .env file
COPY package.json ./
COPY index.js ./
COPY .env ./

# Install dependencies
RUN npm install --production

# === Stage 2: Create the final lightweight image ===
FROM node:alpine

WORKDIR /app

# Copy the Node.js application and .env file from the builder stage
COPY --from=builder /app .

# Expose port 8000 for the web server
EXPOSE 8000

# Start the Node.js web server when the container starts
CMD ["node", "index.js"]

