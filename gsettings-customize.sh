#!/bin/bash

echo "Configuring gsettings..."
gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
gsettings set org.gnome.desktop.interface icon-theme Papirus
gsettings set org.gnome.shell.app-switcher current-workspace-only true

gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Shift><Super>F1']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Shift><Super>F2']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Shift><Super>F3']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Shift><Super>F4']"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Shift><Super>F5']"
gsettings set org.gnome.shell.keybindings switch-to-application-6 "['<Shift><Super>F6']"
gsettings set org.gnome.shell.keybindings switch-to-application-7 "['<Shift><Super>F7']"
gsettings set org.gnome.shell.keybindings switch-to-application-8 "['<Shift><Super>F8']"
gsettings set org.gnome.shell.keybindings switch-to-application-9 "['<Shift><Super>F9']"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 "['<Super>7']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 "['<Super>8']"

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Shift>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Super><Shift>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Super><Shift>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super><Shift>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5 "['<Super><Shift>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6 "['<Super><Shift>6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7 "['<Super><Shift>7']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8 "['<Super><Shift>8']"

gsettings set org.gnome.shell.keybindings focus-active-notification "['<Super>n']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Shift><Super>q']"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Super>o']"

gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot-clip "['<Shift><Super>s']"
gsettings set org.gnome.settings-daemon.plugins.media-keys window-screenshot-clip "['<Primary><Super>s']"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Super>Return"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'gnome-terminal'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Open terminal'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Primary><Super>9"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'nautilus'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Open file manager'

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding "<Shift><Super>i"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command 'firefox ~/Documents/Pikanäppäimet.html'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name 'Show cheat sheet'

gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Primary><Super>0']"

gsettings set org.gnome.settings-daemon.plugins.media-keys play "['<Super>k']"
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['<Shift><Super>k']"
gsettings set org.gnome.settings-daemon.plugins.media-keys previous "['<Alt><Super>k']"

#gsettings set org.gnome.desktop.wm.keybindings move-to-monitor-left "['<Super><Shift>odiaeresis']"
#Ei toimi
