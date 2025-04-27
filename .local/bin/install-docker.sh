#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

echo "Updating package lists..."
apt-get update -y

echo "Installing required pacakages..."
apt-get install -y \
    ca-certificates \
    curl

echo "Adding Docker's official GPG key..."
mkdir -p /etc/apt/keyrings
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo "Setting up Docker's stable repository..."
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

echo "Updating package lists again to include Docker repository..."
apt-get update -y

echo "Installing Docker CE (Community Edition)..."
apt-get install -y docker-ce docker-ce-cli containerd.io

echo "Starting Docker service..."
systemctl start docker

echo "Enabling Docker to start on boot..."
systemctl enable docker

echo "Verifying Docker installation..."
docker --version
if [ $? -ne 0 ]; then
    echo "Docker installation failed. Exiting..."
    exit 1
fi
