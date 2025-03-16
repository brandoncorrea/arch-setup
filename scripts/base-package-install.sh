#!/bin/sh

sudo pacman -S bash curl rlwrap which git base-devel jdk21-openjdk dotnet-sdk-8.0 --noconfirm

# dotnet
echo "export PATH=\"\$PATH:/root/.dotnet/tools\"" >> ~/.bash_profile

# Install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
