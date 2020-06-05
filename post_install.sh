#!/usr/bin/env bash
# This script performs the following post-installation tasks:
# -configure data drive
# -configure megasync
# -deploy docker containers
# -restore and enable systemd scheduled tasks
# -restore scripts
# etc

function mount_data() {

  # configure and mount data drive
  echo "Creating data drive mount point..."
  mkdir /mnt/data
  chmod 777 -R /mnt/data
  echo "Unlocking data drive..."
  cryptsetup luksOpen /dev/disk/by-uuid/insert_uuid encrypted_data
  echo "Mounting data drive..."
  mount /dev/mapper/encrypted_data /mnt/data
  
}

function docker_config() {

  # user namespace remapping
  echo \
"{
" userns-remap": \"default\"
}" \
  >> /etc/docker/daemon.json
  
  echo "dockremap:165536:4096" >> /etc/subuid
  echo "dockremap:165536:4096" >> /etc/subgid
  
  systemctl restart docker.service  
  
}


# docker containers:
# portainer
# pihole
# huginn
# transmission
# mosquitto
# openhab
# jabber
# whoogle https://github.com/benbusby/whoogle-search
# post.io (mail server)
# openvpn
# nextcloud
