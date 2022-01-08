#!/bin/bash

print_error()
{
	echo "ERROR:" "$@" 1>&2
}

fix_path()
{
	#In Debian the $PATH-variable does not include /usr/sbin. Fixing this here
	PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/snap/bin:/usr/sbin"
	echo "PATH=\"/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/snap/bin:/usr/sbin\"" > /etc/environment
	export PATH
}

flatpak_install()
{
	apt install -y flatpak gnome-software-plugin-flatpak
	flatpak remote-add --system --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install --system -y flathub com.bitwarden.desktop
	flatpak install --system -y flathub com.spotify.Client
	flatpak install --system -y flathub org.libreoffice.LibreOffice
	flatpak install --system -y flathub org.gimp.GIMP
	flatpak install --system -y flathub us.zoom.Zoom
	flatpak install --system -y flathub org.signal.Signal
	flatpak install --system -y flathub com.nextcloud.desktopclient.nextcloud
}

snap_install()
{
	apt install -y snapd
	snap install core
	snap install firefox
}

enable_non-free()
{
	echo "Adding contrib and non-free repositories..."
	sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list
	apt update
}

apt_install()
{
	apt install -y\
	libnotify-bin\
	lm-sensors\
	vim\
	papirus-icon-theme\
	jq\
	git\
	wget\
	pavucontrol\
	python3-tk\
	zenity\
	cups\
	pip\
	gdb\
	grub-customizer
	
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	apt install -y ./google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb

	apt install -y\
	obs-studio
}

unattended_upgrades()
{
	#Enabling unattended upgrades. One thing less to think about.
	sed -i '29 s/\/\//  /' /etc/apt/apt.conf.d/50unattended-upgrades
	echo "Unattended upgrades enabled"
}

laptop()
{
	apt install -y laptop-detect
	echo "Detecting laptop..."
	laptop-detect
	if [ $? = 0 ]; then
		echo "Laptop detected"
		git clone https://github.com/AdnanHodzic/auto-cpufreq.git #Install auto-cpufreq
		cd auto-cpufreq && echo "i" | ./auto-cpufreq-installer
		auto-cpufreq --install
		#At least on my laptop some cpu governors are not available by default. Loading the necessary kernel modules here.
		printf "cpufreq_conservative\ncpufreq_ondemand\ncpufreq_powersave\ncpufreq_userspace\n" > /etc/modules-load.d/cpufeq.conf
	else
		echo "Laptop not detected"
	fi
}

nvidia()
{
	apt install -y lshw
	echo "Detecting Nvidia card..."
	if [ -n "$(lshw -C display | grep vendor | grep NVIDIA)" ];then
		echo "Nvidia card detected"
		apt install -y nvidia-driver
		NVIDIA=true
		echo "Nvidia proprietary driver installed"
	else
		echo "No NVidia card detected"
	fi
}

plymouth()
{
	echo "Setting up plymouth..."
	apt install -y plymouth plymouth-themes firmware-linux
	echo "Setting plymouth theme..."
	plymouth-set-default-theme -R bgrt
	sed -i 's/#GRUB_GFXMODE=640x480/GRUB_GFXMODE=1920x1080/' /etc/default/grub #My screen is 1920x1080. If your's is not, change this!
	sed -i 's/DEFAULT=\"quiet\"/DEFAULT=\"quiet splash\"/' /etc/default/grub
	update-grub2
}

vimrc()
{
	echo "Setting up vim..."
	printf "set langmap=jh,kj,lk,öl\nset relativenumber\nset number" > /etc/vim/vimrc.local
	#I have a finnish keyboard. You probably don't have so change or remove this.
}

apt_purge()
{
	#Debian with GNOME is bloated. Fixing it.
	echo "Removing extra packages..."
	apt purge -y evolution
	apt purge -y gnome-music 
	apt purge -y rhythmbox 
	apt purge -y shotwell 
	apt purge -y aisleriot 
	apt purge -y five-or-more
	apt purge -y fortune-mod
	apt purge -y four-in-a-row
	apt purge -y gnome-2048
	apt purge -y gnome-chess
	apt purge -y gnome-klotski
	apt purge -y gnome-mahjongg
	apt purge -y gnome-mines
	apt purge -y gnome-nibbles
	apt purge -y gnome-robots
	apt purge -y gnome-sudoku
	apt purge -y gnome-taquin
	apt purge -y gnome-tetravex
	apt purge -y hitori
	apt purge -y hoichess
	apt purge -y iagno
	apt purge -y lightsoff
	apt purge -y quadrapassel
	apt purge -y swell-foop
	apt purge -y tali
	apt purge -y kasumi
	apt purge -y debian-reference-common
	apt purge -y fcitx
	apt purge -y goldendict
	apt purge -y hdate
	apt purge -y libreoffice*
	apt purge -y malcontent
	apt purge -y transmission*
	apt purge -y thunderbird
	apt purge -y synaptic
	apt autoremove -y
}

dev_install()
{
	#TO-DO kvm-setup
	snap install --classic code
	apt install -y fonts-jetbrains-mono #For VSCode
	echo "Setting up Virtualbox..."
	echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bullseye contrib" >> /etc/apt/sources.list
	wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc
	mv oracle_vbox_2016.asc /etc/apt/trusted.gpg.d/
	apt update
	apt install -y virtualbox-6.1\
	build-essential
	usermod -aG vboxusers $USERNAME
	flatpak install --system -y flathub org.gnome.Glade
	flatpak install --system -y flathub ca.desrt.dconf-editor
}

fun_install()
{
	echo "Configuring archictecture..."
	dpkg --add-architecture i386
	apt update
	echo "Installing Steam..."
	apt install -y steam
	if [ $NVIDIA = true ]; then
		apt install -y nvidia-driver-libs:i386
	fi
	apt install -y\
	mesa-vulkan-drivers\
	libglx-mesa0:i386\
	mesa-vulkan-drivers:i386\
	libgl1-mesa-dri:i386
	echo "Installing Minecraft..."
	wget https://launcher.mojang.com/download/Minecraft.deb
	apt install -y ./Minecraft.deb
	rm ./Minecraft.deb
	echo "Installing Discord..."
	flatpak install --system -y flathub com.discordapp.Discord
}

school_install()
{
	flatpak install --system -y flathub org.geogebra.GeoGebra
	flatpak install --system -y flathub com.microsoft.Teams
	flatpak install --system -y flathub org.kde.kdenlive
	flatpak install --system -y flathub org.gnucash.GnuCash
	flatpak install --system -y flathub org.speedcrunch.SpeedCrunch
}

sudo_add()
{
	echo "Adding user $USERNAME to sudo..."
	usermod -aG sudo "$USERNAME"
}

timeshift_setup()
{
	echo "Setting up timeshift..."
	apt install -y timeshift
	timeshift-launcher
}

user_config()
{
	if [ "$SCHOOL" = y ]; then
		sudo -u $USERNAME SCHOOL=y ./user-customize.sh
	fi
	sudo -u $USERNAME ./user-customize.sh
}

appimage_integrate()
{
	echo "Installing appimagelauncher..."
	wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
	apt install -y ./appimage*.deb
	rm ./appimage*.deb
}

corefonts()
{
	apt install -y ttf-mscorefonts-installer
}

ufw_config()
{
	apt install -y ufw
	ufw enable
	ufw allow 1714:1764/udp #For gsconnect
	ufw allow 1714:1764/tcp #For gsconnect
	ufw reload
}

libre_templates()
{
	#Installing libreoffice templates. Libreoffice is installed as a flatpak so the location of templates is not what the deb-package says. Doing it manually.
	echo "Installing Libreoffice templates..."
	mkdir tmpdir
	wget https://github.com/dohliam/libreoffice-impress-templates/releases/download/v2.2/libreoffice-impress-templates-all_2.2-1.deb
	dpkg-deb --extract libreoffice-impress-templates-all_2.2-1.deb tmpdir
	for TEMPLATE in tmpdir/usr/lib/libreoffice/share/template/common/presnt/*; do
		mv "$TEMPLATE" /var/lib/flatpak/app/org.libreoffice.LibreOffice/current/active/files/libreoffice/share/template/common/
	done	
	rm -r tmpdir
}

if [ "$(whoami)" != root ]; then
	print_error "This script must be run as root"
	exit 1
fi

echo -en "Do you want to install the dev-package? [Y/n]"
read -r DEV
if [ -z "$DEV" ];then
	DEV=y
elif [ "$DEV" = y ] || [ "$DEV" = Y ]; then
	DEV=y
elif [ "$DEV" = n ] || [ "$DEV" = N ]; then
	DEV=n
else
	print_error "Unknown option"
	exit 1
fi

echo -en "Do you want to install the fun-package? [Y/n]"
read -r FUN
if [ -z "$FUN" ];then
	FUN=y
elif [ "$FUN" = y ] || [ "$FUN" = Y ]; then
	FUN=y
elif [ "$FUN" = n ] || [ "$FUN" = N ]; then
	FUN=n
else
	print_error "Unknown option"
	exit 1
fi

echo -en "Do you want to install the school-package? [Y/n]"
read -r SCHOOL
if [ -z "$SCHOOL" ];then
	SCHOOL=y
elif [ "$SCHOOL" = y ] || [ "$SCHOOL" = Y ]; then
	SCHOOL=y
elif [ "$SCHOOL" = n ] || [ "$SCHOOL" = N ]; then
	SCHOOL=n
else
	print_error "Unknown option"
	exit 1
fi

echo -en "Give your username: "
read -r USERNAME

id -u "$USERNAME" > /dev/null 2>&1
if [ $? != 0 ]; then
	print_error "That user does not exsist"
	exit 1
fi

apt update && apt upgrade -y
enable_non-free
fix_path
apt_install
snap_install
laptop
nvidia
apt_purge
flatpak_install
libre_templates
plymouth
unattended_upgrades
sudo_add
vimrc
appimage_integrate
corefonts
ufw_config
if [ "$FUN" = y ];then
	echo "Installing fun-pack..."
	fun_install
fi
if [ "$DEV" = y ];then
	echo "Installing dev-pack..."
	dev_install
fi
if [ "$SCHOOL" = y ]; then
	echo "Installing school-pack..."
	school_install
fi
user_config
timeshift_setup
echo "System configuration done. Please remember to reboot to clean up."
