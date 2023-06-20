#!/bin/bash 

groupadd -r pollme;  useradd -r -d /home/max -s /bin/bash -g pollme pollme
mkdir -p /home/max/games
chown max:max /home/max/games

touch  /home/max/games/residentevil
chown max:max /home/max/games/residentevil
chmod 777 /home/max/games/residentevil

mkdir -p /var/log/packer/sys
touch  /var/log/packer/sys/ok-its-me
chmod 020 /var/log/packer/sys/ok-its-me
