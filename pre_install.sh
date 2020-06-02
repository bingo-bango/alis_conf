#!/usr/bin/env bash
# This script:
# 1) installs nfs
# 2) connects to a local pacman cache to speed up install

# install nfs-utils
pacman -S nfs-utils --noconfirm --needed

# set host name for pacman cache server
echo "172.16.0.42 pacserver" >> /etc/hosts

# set up fstab with pacman share
echo "pacserver:/var/cache/pacman/pkg	/var/cache/pacman/pkg		nfs	noauto,nofail,x-systemd.automount,x-systemd.device-timeout=30,_netdev 0 0" >> /etc/fstab

# mount share
mount /var/pacman/pkg/cache

# notify
echo "network pacman cache is ready!"

