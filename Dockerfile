# Use the official Golang image to build the Go app
FROM golang:1.22 AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the Go Modules manifests
COPY . ./

# Download Go module dependencies
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go app
RUN go build -o main .

# Use a minimal base image to run the Go app
FROM debian:bullseye-slim

# Copy the binary from the builder stage
COPY --from=builder /app/main /app/main

# Set the binary as the entrypoint
ENTRYPOINT ["/app/main"]

# Expose port 8080 to the outside world
EXPOSE 8080
