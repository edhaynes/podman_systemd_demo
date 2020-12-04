#!/bin/sh

systemctl stop redis_server.service
systemctl disable redis_server.service
rm -f /etc/systemd/system/redis_server.service
podman stop redis_server
podman rm redis_server

