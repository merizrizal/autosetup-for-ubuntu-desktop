#!/bin/bash
set -e

echo Running automatic setup...
sudo apt install -y python3-pip python3-venv
source ./envrc
ansible-playbook ./playbook_install.yml -u $USER
yq '.prefs_tmp_files' host_vars/localhost.yml | while read value; do echo $value | cat $(yq '.*') | dconf load /org/; done
