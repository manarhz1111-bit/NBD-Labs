#!/bin/bash

if systemctl is-active --quiet mongod && \
   mongosh --quiet --eval 'db.adminCommand({ ping: 1 })' >/dev/null 2>&1
then
    echo "MongoDB is running and reachable."
    exit 0
else
    echo "MongoDB is not reachable."
    exit 1
fi
