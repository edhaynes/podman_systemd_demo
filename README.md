# podman_systemd_demo
Showing podman integration with Systemd to manage lifecycle of container

For this project I created a vm based on fedora33 to act as a sandbox.  Go into the vm and git clone this project to run locally.

Purpose is to show how podman can easily use systemd to manage lifecycle of a container.  Think of a small edge device, too small to run kubernetes, but you would like to run containerized applications on it so that you can isolate application dependences from the OS.  The OS is minimal and just enough to run containers, but you would like to containers to restart if they crash and also restart automatically on reboot.  For this example I'm running redis, an in-memory key value database as an example.  

This demo should be run as root - in fedora

sudo su -

There are 3 scripts.

"launch_redis_container.sh" will pull the redis container, then set appropriate SELinux permissions.  The containerized redis server is launched and mapped to the normal redis networking ports.  Then 'podman generate systemd' creates a systemd unit file based on this container which is enabled and started.  Now your containerized database is running and systemd is managing its lifecycle as a normal linux service.  

At this point the status of the redis-server will be shown (press "q" to get out).

"test_redis_container.sh" exercises the redis database api by setting a value and then retrieving it to show the database is working.  The database is then killed using pkill and you're shown how systemd creates a new container to replace it and also the recovered database is working. The systemd unit file also specifies the container to restart at startup so if you like restart the VM and verify the database is still working.

cleanup.sh stops the redis-server, disables the service, and cleans up the systemd unit file and the container so you can run this demo again from the top if you like.
