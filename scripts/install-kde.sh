#!/bin/sh

sudo pacman -S --noconfirm \
  bluedevil \
  breeze \
  breeze-gtk \
  kde-cli-tools \
  kde-gtk-config \
  kdecoration \
  kglobalacceld \
  kmenuedit \
  kpipewire \
  kscreen \
  kscreenlocker \
  kwayland \
  kwin \
  layer-shell-qt \
  libkscreen \
  libksysguard \
  libplasma \
  plasma-activities \
  plasma-desktop \
  plasma-integration \
  plasma-nm \
  plasma-pa \
  plasma-sdk \
  plasma-systemmonitor \
  plasma-thunderbolt \
  plasma-workspace \
  plasma5support \
  powerdevil \
  qqc2-breeze-style \
  sddm-kcm \
  spectacle \
  systemsettings \
  dolphin \
  konsole \
  sddm \
  xorg

sudo systemctl enable sddm
sudo systemctl set-default graphical.target

# Xorg and Wayland need a driver (e.g., xf86-video-intel, nvidia). Add based on GPU:
# lspci | grep -i vga
# sudo pacman -S --noconfirm xf86-video-intel
