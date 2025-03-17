# Stage 1: Build the application
FROM rust:1.85.0 AS builder

# Set the working directory
WORKDIR /usr/src/app

# Install system dependencies for Leo and Aleo
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    libssl-dev \
    clang \
    llvm \
    git \
    curl \
    libclang-dev \
    libzmq3-dev \
    ca-certificates \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Leo (Aleo's Programming Language)
RUN curl -sSL https://github.com/AleoHQ/leo/releases/download/v0.6.0/leo-v0.6.0-x86_64-linux.tar.gz | tar -xz -C /usr/local/bin

# Install Aleo CLI
RUN curl -sSL https://github.com/AleoHQ/aleo-cli/releases/download/v0.6.0/aleo-cli-v0.6.0-x86_64-linux.tar.gz | tar -xz -C /usr/local/bin

# Install Aleo Node (optional - if needed to run a node)
# RUN curl -sSL https://github.com/AleoHQ/aleo-node/releases/download/v0.6.0/aleo-node-v0.6.0-x86_64-linux.tar.gz | tar -xz -C /usr/local/bin

# Copy your project files into the container (make sure your local project files are copied correctly)
COPY . .

# Build the project (ensure the 'leo' command works with your specific project)
RUN leo build --release

# Stage 2: Runtime Environment
FROM debian:bullseye-slim

# Install necessary runtime dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libclang-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /usr/src/app

# Copy the built binary from the builder stage
COPY --from=builder /usr/src/app/target/release/aleo-zk-compliance .

# Expose necessary ports (adjust if required)
EXPOSE 8080

# Define the entry point
CMD ["./aleo-zk-compliance"]
