#!/bin/bash

# Exit script if any command fails
set -e

# Clone the backend repository
echo "Cloning the backend repository..."
git clone <backend-repository-url> backend

# Navigate into the backend directory
cd backend

# Install backend dependencies
echo "Installing backend dependencies..."
npm install

# Create the .env file for backend and set up environment variables
echo "Setting up backend environment variables..."
cat <<EOF > .env
# Add your backend environment variables here
# Example:
# DB_HOST=localhost
# DB_USER=root
# DB_PASS=password
EOF

# Go back to the root directory
cd ..

# Clone the frontend repository
echo "Cloning the frontend repository..."
git clone <frontend-repository-url> frontend

# Navigate into the frontend directory
cd frontend

# Install frontend dependencies
echo "Installing frontend dependencies..."
npm install

# Go back to the root directory
cd ..

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
      - "5000:3000"
    volumes:
      - ./backend:/app
    depends_on:
      - frontend

  frontend:
    build:
      context: ./frontend
    ports:
      - "3000:3000"
    volumes:
      - ./frontend:/app
EOF

# Build and run the Docker containers
echo "Building and starting Docker containers..."
docker-compose up --build

