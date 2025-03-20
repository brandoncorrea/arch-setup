#!/bin/sh

# Mullvad Browser
gpg --auto-key-locate nodefault,wkd --locate-keys torbrowser@torproject.org

# Yay Apps
yay -S --noconfirm \
  mullvad-browser-bin \
  vscodium-bin \
  nordvpn-bin \
  obsidian \
  intellij-idea-ultimate-edition \
  slack-desktop \
  sozi

# intellij-idea-community-edition if can't log in to ultimate 

# Pacman Apps
pacman -S --noconfirm \
  obsidian \
  firefox \
  inkscape # Recommended for Sozi

# Configure NordVPN
sudo systemctl enable --now nordvpnd
nordvpn set killswitch on
nordvpn set autoconnect on
nordvpn set dns 9.9.9.9
