#!/bin/bash

set -euo pipefail

REPO="percona/mongodb_exporter"

echo "=== Installing latest Percona MongoDB Exporter ==="

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

echo "Latest release: $TAG"

ARCHIVE="mongodb_exporter-${VERSION}.linux-${ARCH}.tar.gz"
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${TAG}/${ARCHIVE}"

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Downloading $ARCHIVE..."

curl -fL "$DOWNLOAD_URL" -o "$TMP_DIR/$ARCHIVE"

tar -xzf "$TMP_DIR/$ARCHIVE" -C "$TMP_DIR"

BINARY=$(find "$TMP_DIR" -type f -name mongodb_exporter | head -n 1)

if [ -z "$BINARY" ]; then
    echo "mongodb_exporter binary was not found."
    exit 1
fi

sudo install -m 0755 "$BINARY" /usr/local/bin/mongodb_exporter

echo "=== MongoDB Exporter installed successfully ==="
echo "Installed version:"
/usr/local/bin/mongodb_exporter --version || true
