# === Stage 1: Build the Go binary ===
FROM golang:latest as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go source code and .env file into the container
COPY main.go ./

# Build the Go application inside the container
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o web-server main.go

# === Stage 2: Create the final lightweight image ===
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the Go binary from the builder stage
COPY --from=builder /app/web-server .

COPY .env ./
# Expose port 8000 for the web server
EXPOSE 8000

# Start the Go web server when the container starts
CMD ["./web-server"]

