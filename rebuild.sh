#!/run/current-system/sw/bin/bash
GIT="git -c user.email='none@example.com' -c user.name='none'"
cd /etc/nixos/
sudo $GIT fetch local master
sudo $GIT reset --hard
sudo nixos-rebuild switch
