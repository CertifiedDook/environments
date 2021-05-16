#!/usr/bin/env bash

trap "exit" INT

ansible-galaxy collection install community.general
ansible-playbook setup.yml --tags desktop -K -i hosts.yml
