#!/usr/bin/env bash
# This script performs the following post-installation tasks:
# set up ssh
# set up docker parameters

ssh_config() {
  
  #notify
  echo "setting up ssh"
  
  # stop sshd if running
  systemctl stop sshd.service

  # create .ssh folder
  mkdir /home/peter/.ssh
  
  # add ssh key to authorized hosts
  cat elitebook.pub > /home/peter/.ssh/authorized_keys

  # change ownership of ssh folder
  chown -hR peter /home/peter/.ssh

  # copy ssh config file
  cat sshd_config > /etc/ssh/sshd_config
  
  # enable and start sshd
  systemctl enable sshd.service
  systemctl start sshd.service
  
  # notify
  echo "ready to connect via ssh"
}

docker_config() {
  echo "setting up docker parameters"
  # user namespace remapping
  cat docker_daemon >> /etc/docker/daemon.json  
  echo "dockremap:165536:4096" >> /etc/subuid
  echo "dockremap:165536:4096" >> /etc/subgid  
  systemctl restart docker.service    
  systemctl enable docker.service
  echo "docker is ready to go"
}

ssh_config
docker_config

echo "script is complete, now run docker deployment (bash docker_deploy)"
