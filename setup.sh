#!/usr/bin/env bash

PKGFILES="packages.arch"
AURPKGFILES="packages.aur"
INSTALLUSER=$(ls /home | head -n 1 | tr -d '/')

pacman -Sy --needed $(cat $PKGFILES)

# AUR must be done one at a time since --nobatchinstall doesn't work... bummer
for AURPKG in $(cat $AURPKGFILES); do
	sudo -u $INSTALLUSER -- yay -Sy --needed --noconfirm --nocleanmenu --nodiffmenu --noeditmenu --noupgrademenu --noremovemake $AURPKG
done

./postinstall.sh $INSTALLUSER
