#!/bin/bash

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

echo "[+] Removing old Docker versions (if any)..."
apt-get remove -y docker docker-engine docker.io containerd runc

echo "[+] Updating package index..."
apt-get update

echo "[+] Installing required packages..."
apt-get install -y ca-certificates curl gnupg

echo "[+] Adding Docker’s GPG key..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | \
    gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "[+] Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "[+] Updating package index with Docker repo..."
apt-get update

echo "[+] Installing Docker Engine and related packages..."
apt-get install -y docker-ce docker-ce-cli containerd.io \
    docker-buildx-plugin docker-compose-plugin

echo "✅ Docker installation complete!"

echo "[i] You can test it with: sudo docker run hello-world"
