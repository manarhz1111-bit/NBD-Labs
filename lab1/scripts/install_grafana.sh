#!/bin/bash

set -euo pipefail

echo "=== Installing latest stable Grafana OSS ==="

sudo apt-get update
sudo apt-get install -y apt-transport-https wget gnupg

sudo mkdir -p /etc/apt/keyrings

sudo wget -q -O /etc/apt/keyrings/grafana.asc \
  https://apt.grafana.com/gpg-full.key

sudo chmod 644 /etc/apt/keyrings/grafana.asc

echo "deb [signed-by=/etc/apt/keyrings/grafana.asc] https://apt.grafana.com stable main" | \
sudo tee /etc/apt/sources.list.d/grafana.list >/dev/null

sudo apt-get update
sudo apt-get install -y grafana

sudo systemctl daemon-reload
sudo systemctl enable --now grafana-server

echo "=== Grafana installed successfully ==="

echo -n "Installed package version: "
dpkg-query -W -f='${Version}\n' grafana

echo -n "Service status: "
systemctl is-active grafana-server

echo -n "Autostart: "
systemctl is-enabled grafana-server
