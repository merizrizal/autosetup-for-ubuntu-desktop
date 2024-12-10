#!/bin/bash
set -e

echo Running automatic setup...
sudo apt install -y python3-pip python3-venv
source ./envrc
mkdir -p $ROOT_DIR/logs
date=$(date "+%Y_%m_%d_%H_%M_%N")
export ANSIBLE_LOG_PATH=$ROOT_DIR/logs/playbook_$date.log
ansible-playbook ./playbook_install.yml -u $USER
yq '.prefs_tmp_files' host_vars/localhost.yml | while read value; do echo $value | cat $(yq '.*') | dconf load /org/; done
