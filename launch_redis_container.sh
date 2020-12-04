#!/bin/sh

podman pull redis
setsebool -P container_manage_cgroup on
podman run -d --name redis_server -p 6379:6379 redis
podman generate systemd redis_server --restart-policy=always -t 5 -f -n
cp ./container-redis_server.service /etc/systemd/system/redis_server.service
systemctl daemon-reload
systemctl enable redis_server.service
systemctl start redis_server.service
systemctl status redis_server.service

