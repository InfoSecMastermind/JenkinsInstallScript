#!/bin/bash
set -e

echo "==> Updating system"
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release software-properties-common

# -------------------------
# Jenkins
# -------------------------
echo "==> Setting up Jenkins repository"
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key \
  | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# -------------------------
# Docker
# -------------------------
echo "==> Setting up Docker repository"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# -------------------------
# Install packages
# -------------------------
echo "==> Installing packages"
sudo apt update
sudo apt install -y \
  fontconfig \
  openjdk-17-jre \
  jenkins \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin \
  net-tools \
  python3 \
  python3-pip \
  python3-venv \
  mariadb-server \
  mariadb-client

# -------------------------
# Enable services
# -------------------------
echo "==> Enabling services"
sudo systemctl enable --now jenkins
sudo systemctl enable --now docker
sudo systemctl enable --now mariadb

# -------------------------
# Docker without sudo (optional but recommended)
# -------------------------
sudo usermod -aG docker $USER

# -------------------------
# Python packages (safe way)
# -------------------------
echo "==> Installing Python packages"
python3 -m pip install --upgrade pip
python3 -m pip install --user streamlit

echo "==> Done. Re-login required for Docker group changes."

