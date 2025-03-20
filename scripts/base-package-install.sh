#!/bin/sh

sudo pacman -S --noconfirm \
  iwd \
  dhcpcd \
  bash \
  curl \
  unzip \
  rlwrap \
  which \
  dnsutils \
  git \
  base-devel \
  nodejs \
  openssh \
  jdk21-openjdk \
  dotnet-sdk-8.0

# Enable Services on boot
sudo systemctl enable iwd
sudo systemctl enable dhcpcd

# dotnet
echo "export PATH=\"\$PATH:/root/.dotnet/tools\"" >> ~/.bash_profile

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
