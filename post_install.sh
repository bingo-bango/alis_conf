#!/usr/bin/env bash
# This script sets up the data drive

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
