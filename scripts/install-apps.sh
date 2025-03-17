#!/bin/sh

# Mullvad Browser
gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org

# VSCodium
yay -S --noconfirm \
  mullvad-browser-bin \
  vscodium-bin \
  nordvpn-bin \
  obsidian \
  intellij-idea-ultimate-edition

# intellij-idea-community-edition if can't log in to ultimate 

pacman -S --noconfirm obsidian

sudo systemctl enable --now nordvpnd
