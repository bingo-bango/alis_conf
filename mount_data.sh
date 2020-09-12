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
}

function create_share() {
  echo "creating share directories"
  mkdir -p /srv/nfs/shared_data
  echo "mount share directories"
  mount --bind /data/shared_data /srv/nfs/shared_data
  echo "update fstab"
  echo "/data/shared_data /srv/nfs/shared_data  none   bind   0   0"
}

create_data
mount_data
share_data
