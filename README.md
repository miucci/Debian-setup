# Debian-setup

## NOTE!
This script works for me. That does not mean that it will work for you! **READ AND UNDERSTAND THE SCRIPTS BEFORE EXECUTING THEM!!!**
You probably also don't need the same programs that I need. For you a lot of this might be just junk so remove what you don't need. I have provided some basic documentation in the script themselves so I higly encourage you to read them. **You should really fork this and make you own version.**

## Execution environment
- A fresh installation of Debian 11
- No additional repositories enabled (only main)
- Only one user to set up
- Debian installed with GNOME, standard Debian installation
- Disk encryption can be enabled or not, doesn't matter

So basically very basic and default Debian 11 installation

## Usage
To execute this script you can either clone this repo or take the scripts form a usb drive etc. Run the script by running `./debian-setup.sh` in the directory where the scripts are located. Note that the script must be run as root. The script will first ask you questions about what packages you want to install. The list is as follows:
- Dev pack - This set of packages includes some development packages like VirtualBox and VSCode
- Fun pack - This set of packages includes Steam and Minecraft
- School pack - This set of packages includes programs that I use at school. You probably don't use the same programs.

The last question asks your username. Give it.
The script will do its work and then execute the other scripts. The other scripts are executed as the user you specified in the beginning. Those scripts will do the user-spesific work. In theory you could maybe just run these user specific scripts to set up another user. Altough I haven't tested this.

## What the scripts do

### System-wide (debian-setup.sh)
- Enable non-free and contrib-repositories
- Install basic cli utilities
- Install proprietary NVidia-drivers if needed
- Install powersaver programs if on a laptop
- Remove unnecessary programs
- Set up snap and flatpak
- Install programs using primarily flatpak, also some snaps
- Set up a Plymouth splashscreen
- Enable unattended-upgrades
- Enable AppImage system integration
- Install MS Corefonts
- Set up a firewall
- Install chosen software packages
- Set up Timeshift

### User specific (user-customize.sh and gsettings-customize.sh)
These actions are executed for the user you specified in the beginning of the script
- Install some GNOME-extensions
- Install some AppImages
- Adding "ll=ls -l" alias
- Setting up dark theme
- Use Papirus icon theme
- Set up keyboard shortcuts (you probably want to change them)

## Contributing
I don't really expect anyone to contribute anything to this script. If you still for some obscure reason want to contribute, you are welcome. Just keep in mind that this is a script for my personal use. So you probably don't know what I will accept and what reject. So you should probably just fork this and create your own for your own use.


