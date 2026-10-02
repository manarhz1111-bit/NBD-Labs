#!/bin/bash

set -e

BACKUP_DIR=$(ls -dt "$HOME"/mongodb-backups/all_training_* | head -n 1)

echo "Using backup: $BACKUP_DIR"
echo "Restoring university.students..."

mongorestore \
  --username labAdmin \
  --authenticationDatabase admin \
  --nsInclude="university.students" \
  "$BACKUP_DIR"

echo "students collection restored successfully."
