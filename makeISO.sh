#!/bin/bash
#
#  This script expects to be in the top level of the ubuntu iso
#  directory.
#  
#  Scripted process to make a new ISO after changes to the 
#  preseed file have been made. This is to speed up the 
#  testing process.
#

if ! [ -f README.diskdefines ] ; then
    echo "[ERROR]"
    echo "  $0 is not in the top directory of the Ubuntu ISO."
    echo "  Move $0 to the top directory and run again."
    exit 0
fi

# Make a directory to hold the ISO
if ! [ -d $HOME/Documents/UbuntuUnattendedISO/ ] ; then
    mkdir $HOME/Documents/UbuntuUnattendedISO/
fi

# Remove the old ISO if it exists
if [ -f $HOME/Documents/UbuntuUnattendedISO/ubuntu-unattended-install.iso ] ; then
    rm $HOME/Documents/UbuntuUnattendedISO/ubuntu-unattended-install.iso
fi

# Edit the preseed file using vim
vim ./ks.preseed

# Make ISO command
mkisofs -D -r -V "UNATTENDED_UBUNTU" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o $HOME/Documents/UbuntuUnattendedISO/ubuntu-unattended-install.iso .
