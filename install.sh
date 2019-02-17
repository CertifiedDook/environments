#!/usr/bin/env bash

sudo dnf install ansible -y && ansible-playbook setup.yml --tags desktop -K -i hosts.yml
