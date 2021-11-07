#!/bin/bash

echo "Configuring user prefrences..."
./gsettings-customize.sh #Script to set dconf values. 
echo "Adding aliases..."
echo "alias ll=\"ls -l\"" >> ~/.bashrc
#Installing shell extensions manually
gsettings set org.gnome.shell enabled-extensions "['tray-icons@zhangkaizhao.com', 'gsconnect@andyholmes.github.io', 'temperature@xtranophilist', 'sensory-perception@HarlemSquirrel.github.io', 'places-menu@gnome-shell-extensions.gcampax.github.com', 'extra-panels@darkxst.feathertop.org']"
wget https://extensions.gnome.org/extension-data/gsconnectandyholmes.github.io.v43.shell-extension.zip
wget https://extensions.gnome.org/extension-data/tray-iconszhangkaizhao.com.v6.shell-extension.zip
wget https://extensions.gnome.org/extension-data/sensory-perceptionHarlemSquirrel.github.io.v13.shell-extension.zip
mkdir $HOME/tmp
cd
for EXTENSION in gsconnectandyholmes.github.io.v43.shell-extension.zip tray-iconszhangkaizhao.com.v6.shell-extension.zip sensory-perceptionHarlemSquirrel.github.io.v13.shell-extension.zip; do
	mv $EXTENSION tmp/
	cd tmp
	unzip $EXTENSION
	ID=$(jq .uuid metadata.json | tr -d '"')
	cd ..
	mkdir -p ~/.local/share/gnome-shell/extensions/$ID
	rm tmp/$EXTENSION
	for FILE in tmp/*; do
		mv "$FILE" ~/.local/share/gnome-shell/extensions/$ID/
	done
done

mkdir -p ~/Applications/
wget https://github.com/nextcloud/desktop/releases/download/v3.3.6/Nextcloud-3.3.6-x86_64.AppImage
mv Nextcloud*.AppImage ~/Applications/
chmod +x ~/Applications/Nextcloud*.AppImage
cp /var/lib/flatpak/app/com.bitwarden.desktop/current/active/export/share/applications ~/.config/autostart/ #Autostarting Bitwarden

if [ "$SCHOOL" = y ]; then
	wget https://github.com/lehtoroni/lmath-issues/releases/download/r1.7/LMath_Linux_r1.7.AppImage
	mv LMath*.AppImage ~/Applications/
	#Math editor used in our school. You probably don't need it.
fi
