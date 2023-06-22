#!/usr/bin/env bash

trap "exit" INT

if ! command -v ansible &> /dev/null
then
  sudo rpm-ostree install ansible pamu2fcfg --idempotent --apply-live
fi

ansible-playbook setup.yml --tags desktop -K -i hosts.yml

if [ ! -f ~/.backup_password.asc ]; then
  PASSWORD=$(kdialog --password 'Provide the backup password')
  echo "$PASSWORD" | gpg --quiet --encrypt > ~/.backup_password.asc
fi

if [ ! -f ~/.config/Yubico/u2f_keys ]; then
  echo 'Enter Yubikey PIN then press it...'
  pamu2fcfg -uczocher > ~/.config/Yubico/u2f_keys
fi
