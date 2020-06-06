#!/usr/bin/env bash
# This script sets up the data drive

function mount_data() {
  # configure and mount data drive
  echo "Creating data drive mount point..."
  mkdir /mnt/data
  chmod 777 -R /mnt/data
  echo "Unlocking data drive..."
  #cryptsetup luksOpen /dev/disk/by-uuid/insert_uuid encrypted_data
  echo "172.16.0.42 pacserver" >> /etc/hosts
  echo "latitude:/srv/nfs/data	/mnt/data		nfs	defaults,rsize=32768,wsize=32768,timeo=900,retrans=5,_netdev	0 0" >> /etc/fstab
  echo "Mounting data drive..."
  #mount /dev/mapper/encrypted_data /mnt/data
  mount /mnt/data
}

function post_install() {
  cd /mnt/data/serverconfig
  echo "ready to run post install scripts"
  bash post_install
 }
 
 mount_data
 post_install
