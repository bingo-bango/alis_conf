#!/usr/bin/env bash
# This script sets up the data drive

function create_data() {
  # configure and mount data drive
  echo "Creating data drive mount point..."
  mkdir /data
  chmod 777 -R /data
}

function mount_data() {
  echo "Unlocking data drive..."
  cryptsetup luksOpen /dev/disk/by-uuid/73cd4968-6492-4f07-9780-e12236581d5e encrypted_data
   echo "Mounting data drive..."
  mount /dev/mapper/encrypted_data /data
  mount --bind /data/shared_data /srv/nfs/shared_data
  echo "Screen blanking"
  setterm --blank force --term linux </dev/tty1
}

function create_share() {
  echo "creating share directories"
  mkdir -p /srv/nfs/shared_data
  echo "mount share directories"
  mount --bind /data/shared_data /srv/nfs/shared_data
  #echo "update fstab"
  #echo "/data/shared_data /srv/nfs/shared_data  none   bind   0   0" >> /etc/fstab
}

function enable_nfs() {
  echo "/srv/nfs/shared_data 192.168.1.0/24(rw,sync,nohide)" >> /etc/exports
  exportfs -arv
  systemctl start nfs-server.service
  systemctl enable nfs-server.service  
}

create_data
mount_data
create_share
enable_nfs
