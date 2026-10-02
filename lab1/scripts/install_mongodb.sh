#!/bin/bash

set -e

echo "=== Installing MongoDB 9.0 on Ubuntu 22.04 ==="

sudo apt-get update
sudo apt-get install -y gnupg curl

curl -fsSL https://pgp.mongodb.com/server-9.asc | \
sudo gpg --yes -o /usr/share/keyrings/mongodb-server-9.gpg \
--dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-9.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/9.0 multiverse" | \
sudo tee /etc/apt/sources.list.d/mongodb-org-9.0.list

sudo apt-get update
sudo apt-get install -y mongodb-org

sudo systemctl enable mongod
sudo systemctl start mongod

echo "=== MongoDB installation completed ==="
mongod --version
