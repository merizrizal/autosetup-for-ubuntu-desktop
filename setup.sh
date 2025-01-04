#!/bin/bash
set -e

echo Running automatic setup...
sudo apt install -y python3-pip python3-venv
source ./envrc
mkdir -p $ROOT_DIR/logs
date=$(date "+%Y_%m_%d_%H_%M_%N")
export ANSIBLE_LOG_PATH=$ROOT_DIR/logs/playbook_$date.log
ansible-playbook ./playbook_install.yml -u $USER
$HOME/.local/bin/yq '.prefs_tmp_files' host_vars/localhost.yml | while read value; do echo $value | cat $($HOME/.local/bin/yq '.*') | dconf load /org/; done

echo "Will reboot in 7 seconds"
echo "Press ctrl + c to abort"
for i in {1..7}; do echo $i; sleep 1; done
sudo reboot
