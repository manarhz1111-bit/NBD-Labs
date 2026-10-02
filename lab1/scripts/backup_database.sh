#!/bin/bash

set -e

BACKUP_ROOT="$HOME/mongodb-backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$BACKUP_ROOT/university_$TIMESTAMP"

mkdir -p "$BACKUP_DIR"

echo "Creating backup of university database..."

mongodump \
  --username labAdmin \
  --authenticationDatabase admin \
  --db university \
  --out "$BACKUP_DIR"

echo "Backup completed successfully."
echo "Backup location: $BACKUP_DIR"

ls -lah "$BACKUP_DIR/university"
