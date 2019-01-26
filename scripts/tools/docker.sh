#!/usr/bin/env bash

yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo


yum install -y docker-ce-$K8S_DOCKER_VERSION

systemctl enable docker && systemctl start docker

# if [ ! -d "/home/$USER/synced-folder/docker" ]; then
#   mkdir /home/$USER/synced-folder/docker
# fi
#
# chmod 755 /etc/docker
#
# cat > /etc/docker/daemon.json <<EOF
# {
#   "graph": "/home/${USER}/synced-folder/docker",
#   "storage-driver": "overlay"
# }
# EOF

systemctl daemon-reload && systemctl restart docker