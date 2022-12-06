#!/usr/bin/env bash

trap "exit" INT

sudo rpm-ostree install ansible --idempotent --apply-live

ansible-playbook setup.yml --tags desktop -K -i hosts.yml
