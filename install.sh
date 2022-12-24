#!/usr/bin/env bash

trap "exit" INT

if ! command -v ansible &> /dev/null
then
  sudo rpm-ostree install ansible --idempotent --apply-live
fi

ansible-playbook setup.yml --tags desktop -K -i hosts.yml
