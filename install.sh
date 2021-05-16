#!/usr/bin/env bash

trap "exit" INT

sudo dnf install ansible -y -q

ansible-playbook setup.yml --tags desktop -K -i hosts.yml

if test -f ~/.mozilla/native-messaging-hosts/com.justwatch.gopass.json; then
  echo "gopass already installed for firefox"
else
  echo "configuring gopass firefox plugin"
  gopass jsonapi configure --browser firefox
  xdg-open https://addons.mozilla.org/pl/firefox/addon/gopass-bridge/
fi

if test -d ~/.password-store; then
  echo "password-store already cloned"
else
  echo "cloning password-store"
  git clone git@bitbucket.org:czocher/pass.git ~/.password-store
fi
