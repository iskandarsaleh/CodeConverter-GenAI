#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Clone the backend repository
echo "Cloning the backend repository..."
git clone <backend-repository-url> backend

# Clone the frontend repository
echo "Cloning the frontend repository..."
git clone <frontend-repository-url> frontend

# Create Docker Compose file
echo "Creating Docker Compose file..."
cat <<EOF > docker-compose.yml
version: '3'

services:
  backend:
    build: 
      context: ./backend
    env_file: ./backend/.env
    ports:
      - "5000:3000" # Expose the backend on port 5000
    volumes:
      - ./backend:/app

  frontend:
    build:
      context: ./frontend
    ports:
      - "3000:3000" # Expose the frontend on port 3000
    volumes:
      - ./frontend:/app
EOF

# Create a .env file for backend (optional, adjust as needed)
echo "Setting up backend environment variables..."
cat <<EOF > backend/.env
# Add your backend environment variables here
# Example:
# DB_HOST=localhost
# DB_USER=root
# DB_PASS=password
EOF

# Build and run Docker containers
echo "Building and starting Docker containers..."
docker-compose up --build

