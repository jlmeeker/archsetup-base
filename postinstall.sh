#!/usr/bin/env bash

INSTALLUSER=$1

# set shell
chsh -s /usr/bin/fish $INSTALLUSER

# disable services
SERVICES_OFF=""
for SVC in $SERVICES_OFF; do
	systemctl stop $SVC
	systemctl disable $SVC
done

# enable services
SERVICES_ON="acpid thermald"
for SVC in $SERVICES_ON; do
	systemctl start $SVC
	systemctl enable $SVC
done

# user groups
GROUPS=""
if [ "$GROUPS" != "" ]; then
	usermod -aG $GROUPS $INSTALLUSER
fi

# dotfiles
cp -f dotfiles/.tmux.conf /home/$INSTALLUSER/
mkdir -p /home/$INSTALLUSER/.config
cp -af dotfiles/fish /home/$INSTALLUSER/.config/
cp -af dotfiles/alacritty /home/$INSTALLUSER/.config/
cp -f dotfiles/.xinitrc /home/$INSTALLUSER/

# dotfile - fix perms
chown -R $INSTALLUSER:$INSTALLUSER /home/$INSTALLUSER
