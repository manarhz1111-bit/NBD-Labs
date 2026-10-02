#!/bin/bash

case "$1" in
  start)
    sudo systemctl start mongod
    echo "MongoDB started."
    ;;

  stop)
    sudo systemctl stop mongod
    echo "MongoDB stopped."
    ;;

  restart)
    sudo systemctl restart mongod
    echo "MongoDB restarted."
    ;;

  status)
    systemctl status mongod --no-pager
    ;;

  *)
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
    ;;
esac
