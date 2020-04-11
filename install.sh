#!/usr/bin/env bash

trap "exit" INT

sudo dnf install ansible -y -q

ansible-playbook setup.yml --tags desktop -K -i hosts.yml

if test -f ~/.config/Yubico/u2f_keys; then
  echo "pamu2fcfg already configured for user"
else
  echo "configuring pamu2fcfg for user, press the button"
  pamu2fcfg > ~/.config/Yubico/u2f_keys
fi

if sudo test -f /root/.config/Yubico/u2f_keys; then
  echo "pamu2fcfg already configured for root"
else
  echo "configuring pamu2fcfg for root, press the button"
  sudo pamu2fcfg > /root/.config/Yubico/u2f_keys
fi

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
