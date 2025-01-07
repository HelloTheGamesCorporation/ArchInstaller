echo "Welcome to arch-insraller! Which disk do you want to install it on?"
echo "vda"
echo "nvme0n1"
echo "sda"
read -p "Choose a disk(Enter in words): " answer
case $answer in
	vda)echo "Good, perform disk partitioning for vda"
	  sfdisk /dev/vda < partition_mapVDA.txt;;
	nvme0n1)echo "Good, perform disk partitioning for nvme0n1"
	  sfdisk /dev/nvme0n1 < partition_mapNVME.txt;;
	sda)echo "Good, perform disk partitioning for sda"
	  sfdisk /dev/sda < partition_mapSDA.txt;;

esac
mkfs.vfat /dev/"$answer""1"
mkfs.ext4 /dev/"$answer""2"

mount /dev/"$answer""2" /mnt
mkdir -p /mnt/boot/efi
mount /dev/"$answer""1" /mnt/boot/efi

pacstrap /mnt base base-devel linux linux-firmware linux-headers vim vi grub efibootmgr sddm xfce4 xorg ttf-ubuntu-font-family ttf-hack ttf-dejavu ttf-opensans \
	bash-completion networkmanager


cat archroot.sh | arch-chroot /mnt bash


umount -R /mnt
reboot
