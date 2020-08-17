#!/usr/bin/env bash
# This script sets up the data drive

function mount_data() {
  # configure and mount data drive
  echo "Creating data drive mount point..."
  mkdir /mnt/data
  chmod 777 -R /mnt/data
  echo "Unlocking data drive..."
  cryptsetup luksOpen /dev/disk/by-uuid/73cd4968-6492-4f07-9780-e12236581d5e encrypted_data
  #echo "lat:/srv/nfs/data	/mnt/data		nfs	defaults,rsize=32768,wsize=32768,timeo=900,retrans=5,_netdev	0 0" >> /etc/fstab
  echo "Mounting data drive..."
  mount /dev/mapper/encrypted_data /mnt/data
}

 
 mount_data

