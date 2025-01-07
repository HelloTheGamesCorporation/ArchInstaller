#!/bin/bash

if [ "$(mount | grep '/mnt ' | sed 's/on.*//')" == "/dev/nvme0n1p2" ];
then
        disk="nvme0n1"
fi

if [ "$(mount | grep '/mnt ' | sed 's/on.*//')" == "/dev/sda2" ];
then
        disk="sda"
fi

if [ "$(mount | grep '/mnt ' | sed 's/on.*//')" == "/dev/vda2" ];
then
        disk="vda"
fi

grub-install /dev/"$disk"
grub-mkconfig -o /boot/grub/grub.cfg

useradd -m virt
echo "virt:1" | chpasswd
echo "root:1" | chpasswd

echo "virt ALL=(ALL:ALL) ALL" >> /etc/sudoers

systemctl enable NetworkManager
systemctl enable sddm

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen

