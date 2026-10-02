#!/bin/bash

set -e

BACKUP_ROOT="$HOME/mongodb-backups"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$BACKUP_ROOT/all_training_$TIMESTAMP"

mkdir -p "$BACKUP_DIR"

DATABASES=("university" "research")

echo "Creating backup of all training databases..."

for DB in "${DATABASES[@]}"
do
  echo "Backing up database: $DB"

  mongodump \
    --username labAdmin \
    --authenticationDatabase admin \
    --db "$DB" \
    --out "$BACKUP_DIR"
done

echo "All training databases backed up successfully."
echo "Backup location: $BACKUP_DIR"

find "$BACKUP_DIR" -maxdepth 2 -type f | sort
