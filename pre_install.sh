#!/usr/bin/env bash
# This script:
# 1) syncs pacman
# 2) connects to a local network pacman cache to speed up install
# 3) pulls latest alis script
# 4) pulls customised config files

# Set this to 1 if a local pacman cache server is being used
Local_Cache=0

# Set the local cache IP if needed
Local_Cache_IP="192.168.1.123"

 if [ $Local_Cache = 1 ]
 then
 
  # set host name for pacman cache server
  echo "$Local_Cache_IP pacserver" >> /etc/hosts

  # set up fstab with pacman share
  echo "pacserver:/var/cache/pacman/pkg	/var/cache/pacman/pkg		nfs	noauto,nofail,x-systemd.automount,x-systemd.device-timeout=30,_netdev 0 0" >> /etc/fstab

  # mount share
  mount /var/cache/pacman/pkg

  # notify
  echo "network pacman cache is ready!"
  fi
  


# pull latest alis download script from the repo
wget https://raw.githubusercontent.com/picodotdev/alis/master/download.sh | bash

# pull customised config files
wget https://raw.githubusercontent.com/bingo-bango/alis_conf/master/alis_latitude.conf
wget https://raw.githubusercontent.com/bingo-bango/alis_conf/master/alis_T500.conf
wget https://raw.githubusercontent.com/bingo-bango/alis_conf/master/alis_elitebook.conf

# pull latest alis using download script
bash download.sh

 if [ $Local_Cache = 1 ]
 then
  # patch alis so that local pacman cache is used
  sed -i 's/pacstrap/pacstrap -c/g' alis.sh
  fi

echo "Operation complete. Replace the alis.conf file with the customized one [alis_XXXX.conf] and run: bash alis.sh"
