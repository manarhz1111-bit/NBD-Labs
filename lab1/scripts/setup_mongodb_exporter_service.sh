#!/bin/bash

set -euo pipefail

SERVICE_USER="mongodb_exporter"
CONFIG_DIR="/etc/mongodb_exporter"
PASSWORD_FILE="$CONFIG_DIR/mongodb_monitor_password"

echo "=== Configuring MongoDB Exporter systemd service ==="

if ! id "$SERVICE_USER" >/dev/null 2>&1; then
    sudo useradd \
      --system \
      --no-create-home \
      --shell /usr/sbin/nologin \
      "$SERVICE_USER"
fi

sudo install -d \
  -m 0750 \
  -o root \
  -g "$SERVICE_USER" \
  "$CONFIG_DIR"

read -rsp "Enter password for mongodbMonitor: " MONITOR_PASSWORD
echo

printf '%s' "$MONITOR_PASSWORD" | \
  sudo tee "$PASSWORD_FILE" >/dev/null

unset MONITOR_PASSWORD

sudo chown root:"$SERVICE_USER" "$PASSWORD_FILE"
sudo chmod 0640 "$PASSWORD_FILE"

sudo tee /etc/systemd/system/mongodb_exporter.service >/dev/null <<'EOF'
[Unit]
Description=Percona MongoDB Exporter
After=network.target mongod.service
Requires=mongod.service

[Service]
Type=simple
User=mongodb_exporter
Group=mongodb_exporter

Environment="MONGODB_USER=mongodbMonitor"
Environment="MONGODB_URI=mongodb://127.0.0.1:27017/?authSource=admin"

ExecStart=/bin/sh -c 'export MONGODB_PASSWORD="$(cat /etc/mongodb_exporter/mongodb_monitor_password)"; exec /usr/local/bin/mongodb_exporter --collector.diagnosticdata'

Restart=on-failure
RestartSec=5

NoNewPrivileges=true
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable mongodb_exporter
sudo systemctl restart mongodb_exporter

echo "=== MongoDB Exporter service configured ==="
echo -n "Service status: "
systemctl is-active mongodb_exporter
echo -n "Autostart: "
systemctl is-enabled mongodb_exporter
