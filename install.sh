#!/usr/bin/env bash

trap "exit" INT

sudo dnf install ansible -y -q

ansible-playbook setup.yml --tags desktop -K -i hosts.yml
