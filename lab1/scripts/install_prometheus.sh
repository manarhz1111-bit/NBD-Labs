#!/bin/bash

set -euo pipefail

REPO="prometheus/prometheus"

echo "=== Installing latest stable Prometheus ==="

sudo apt-get update
sudo apt-get install -y curl tar

case "$(uname -m)" in
  x86_64)
    ARCH="amd64"
    ;;
  aarch64|arm64)
    ARCH="arm64"
    ;;
  *)
    echo "Unsupported architecture: $(uname -m)"
    exit 1
    ;;
esac

LATEST_URL=$(curl -Ls -o /dev/null -w '%{url_effective}' \
  "https://github.com/${REPO}/releases/latest")

TAG="${LATEST_URL##*/}"
VERSION="${TAG#v}"

echo "Latest stable release: $TAG"

ARCHIVE="prometheus-${VERSION}.linux-${ARCH}.tar.gz"
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${TAG}/${ARCHIVE}"

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Downloading $ARCHIVE..."

curl -fL "$DOWNLOAD_URL" -o "$TMP_DIR/$ARCHIVE"

tar -xzf "$TMP_DIR/$ARCHIVE" -C "$TMP_DIR"

SOURCE_DIR="$TMP_DIR/prometheus-${VERSION}.linux-${ARCH}"

sudo install -m 0755 "$SOURCE_DIR/prometheus" /usr/local/bin/prometheus
sudo install -m 0755 "$SOURCE_DIR/promtool" /usr/local/bin/promtool

if ! id prometheus >/dev/null 2>&1; then
    sudo useradd \
      --system \
      --no-create-home \
      --shell /usr/sbin/nologin \
      prometheus
fi

sudo mkdir -p /etc/prometheus
sudo mkdir -p /var/lib/prometheus

sudo chown prometheus:prometheus /var/lib/prometheus

sudo tee /etc/prometheus/prometheus.yml >/dev/null <<'EOF'
global:
  scrape_interval: 5s

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets:
          - "127.0.0.1:9090"

  - job_name: "mongodb"
    static_configs:
      - targets:
          - "127.0.0.1:9216"
EOF

sudo chown root:prometheus /etc/prometheus/prometheus.yml
sudo chmod 0644 /etc/prometheus/prometheus.yml

sudo tee /etc/systemd/system/prometheus.service >/dev/null <<'EOF'
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target mongodb_exporter.service

[Service]
Type=simple
User=prometheus
Group=prometheus

ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.listen-address=0.0.0.0:9090

Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl restart prometheus

echo "=== Prometheus installed successfully ==="

echo -n "Version: "
prometheus --version | head -n 1

echo -n "Service status: "
systemctl is-active prometheus

echo -n "Autostart: "
systemctl is-enabled prometheus
