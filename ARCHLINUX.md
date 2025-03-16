# Arch Linux Install

## ISO

These steps were performed on a MacOS. Steps may be different on other operating systems.

### Download the ISO

Follow the BitTorrent download steps here: https://archlinux.org/download/

On MacOS, download the .torrent file and download the ISO with [qBittorrent](https://www.qbittorrent.org/download).

### Verify the ISO

Compare the output of `shasum` to the SHA256 value on the archlinux download page. These should match.

    shasum -a 256 your-archlinux-download.iso

### Create a bootable USB

Insert a small USB drive and follow the commands, where `/dev/disk2` is the name of your USB drive:


    # Locate your USB drive (`/dev/diskN`)
    diskutil list

    # Unmount the USB
    diskutil unmountDisk /dev/disk2

    # Write the ISO (rdisk = raw disk)
    sudo dd if=~/path/to/your-archlinux-download.iso of=/dev/rdisk2 bs=1m

    # Eject the USB
    diskutil eject /dev/disk2


Remove the USB from the machine.

## Booting the live environment

### Disable Secure Boot

1. Power OFF the machine
2. Power ON the machine and button mash: ESC + F10
3. Find your way into the boot settings and disable secure boot

### Boot from USB

1. Power OFF the machine
2. Power ON the machine and button mash: ESC + F9
3. Select your Arch Live USB drive

## Installation

Follow the steps here to set up your hard drive:
- https://wiki.archlinux.org/title/Installation_guide

### Wi-Fi

You will need to connect your live environment to the internet. Use either an Ethernet cable (automatic) or Wi-Fi (steps below):

    iwctl                              # Enter iwctl
    station wlan0 scan                 # Scan for networks
    station wlan0 get-networks         # List available networks
    station wlan0 connect YOUR_NETWORK # Connect to your network (with password)
    exit                               # Exit iwctl
    ping archlinux.org                 # Test your connection

### Preparing the Drive

Follow these steps for a UEFI machine.

For the Swap partition, 4GB is good for 8-16GB RAM. Increase this if you have more ram (e.g., 8GB for 32GB RAM).

#### Partitioning

    # Locate the drive to install Arch on (/dev/sdaN, /dev/nvmeNnN)
    lsblk

    # Unmount and swapoff the drive
    unmount /dev/sda1p1 # Mounted Partitions
    swapoff /dev/sta1p2 # Swap partitions

    # Start fdisk
    fdisk /dev/sda1

    # Set GPT partition table
    g

    # Create EFI partition
    n       # New Partition
    1       # Partition Number 1
    <Enter> # Default First Sector
    +1G     # 1GB Last Sector
    t       # Set the Partition Type
    1       # EFI System Type

    # Create the Swap partition
    n       # New Partition
    1       # Partition Number 2
    <Enter> # Default First Sector
    +4G     # 4GB Second Sector
    t       # Set the Partition Type
    2       # For Partition Number 2
    19      # Linux Swap Type

    # Create the Root partition
    n       # New Partition
    3       # Partition Number 3
    <Enter> # Default First Sector
    <Enter> # Remainder of the Drive

    # Verify and write
    p # List the layout
    w # Write changes and exit

#### Formatting Partitions

    # Format EFI Partition
    mkfs.fat -F 32 /dev/sda1p1
    
    # Format Swap Partition
    mkswap /dev/sda1p2

    # Format Root Partition
    mkfs.ext4 /dev/sda1p3

#### Mount and Swapon

    # Mount the root
    mount /dev/sda1p3 /mnt

    # Mount the EFI
    mount --mkdir /dev/sda1p1 /mnt/boot

    # Swapon the Swap
    swapon /dev/sda1p2

    # Verify
    lsblk

### Pacstrap

In addition to `base`, `linux`, and `linux-firmware`, include the following installations:
- `intel-ucode` or `amd-ucode` based on the CPU
- `vim`
- `sudo`
- `grub efibootmgr` if you need a bootloader

### GRUB

    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg

### systemd-boot

    bootctl install
    blkid /dev/nvme1n1p3 # Note UUID for the next step

```
# Write to vim /boot/loader/entries/arch.conf

title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img  # or amd-ucode.img if AMD
initrd  /initramfs-linux.img
options root=UUID=your-root-uuid rw
```

```
# Write to /boot/koader/loader.conf

default arch.conf
timeout 5
```
