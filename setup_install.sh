#!/usr/bin/env bash
# This script:
# 1) installs nfs
# 2) connects to a local pacman cache to speed up install

# install nfs-utils
pacman -S nfs-utils

# set up fstab with pacman share
echo "INSERT FSTAB LINE" >> /etc/fstab

# mount share
mount /var/pacman/pkg/cache

# notify
echo "network pacman cache is ready!"

