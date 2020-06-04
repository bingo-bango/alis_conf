#!/usr/bin/env bash
# This script:
# 1) syncs pacman
# 2) connects to a local network pacman cache to speed up install
# 3) pulls latest alis script
# 4) pulls customised config files

# sync pacman
#pacman -Sy

# install nfs-utils
#pacman -S nfs-utils --noconfirm --needed

# set host name for pacman cache server
echo "172.16.0.42 pacserver" >> /etc/hosts

# set up fstab with pacman share
echo "pacserver:/var/cache/pacman/pkg	/var/cache/pacman/pkg		nfs	noauto,nofail,x-systemd.automount,x-systemd.device-timeout=30,_netdev 0 0" >> /etc/fstab

# mount share
mount /var/cache/pacman/pkg

# notify
echo "network pacman cache is ready!"

# pull latest alis from the repo
wget https://raw.githubusercontent.com/picodotdev/alis/master/download.sh | bash

# pull customised config files
wget https://raw.githubusercontent.com/bingo-bango/alis_conf/master/alis_latitude.conf
