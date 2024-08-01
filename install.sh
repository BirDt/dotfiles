mkdir -p ~/.config
alias cp="cp -f"

### Update
sudo xbps-install -Syu

### Basic System Setup
sudo xbps-install emacs-gtk3 xorg-minimal xorg-fonts bspwm rxvt-unicode lightdm lightdm-webkit2-greeter elogind sxhkd mesa-dri xrandr feh wget curl git

# If we have an Atom IGPU then we need the xf86 driver
if lspci -v -s $(lspci | grep ' VGA ' | cut -d" " -f 1) | grep -q "Atom"; then
    sudo xbps-install xf86-video-intel
fi

# Install fonts
sudo xbps-install font-ibm-plex-otf font-ibm-plex-ttf noto-fonts-ttf noto-fonts-cjk

## Compositing
# Install compositor
sudo xbps-install picom

# Clone ~/.config/picom/picom.conf
mkdir -p ~/.config/picom
cp ~/.dotfiles/config/picom.conf ~/.config/picom/picom.conf

## Link bg image to .bg.png
cp ~/.dotfiles/bg.png ~/.bg.png

## Link .bashrc
cp ~/.dotfiles/.bashrc ~/.bashrc

## Set up lightdm
# Enable lightdm
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/elogind /var/service
sudo ln -s /etc/sv/lightdm /var/service

# Set up Litarvan LightDM theme
cd /usr/share/lightdm-webkit/themes
sudo git clone https://github.com/naueramant/lightdm-webkit-sequoia sequoia
cd ~

# Clone /etc/lightdm/lightdm.conf /etc/lightdm/lightdm-webkit2-greeter.conf /usr/share/lightdm-webkit/themes/sequoia/css/arc.css /usr/share/lightdm-webkit/themes/sequoia/config.js
sudo cp ~/.dotfiles/etc/lightdm.conf /etc/lightdm/lightdm.conf
sudo cp ~/.dotfiles/etc/lightdm-webkit2-greeter.conf /etc/lightdm/lightdm-webkit2-greeter.conf
sudo cp ~/.dotfiles/usr/lightdm-theme/arc.css /usr/share/lightdm-webkit/themes/sequoia/css/arc.css
sudo cp ~/.dotfiles/usr/lightdm-theme/config.js /usr/share/lightdm-webkit/themes/sequoia/config.js

# Link .bg.png to /usr/share/lightdm-webkit/themes/sequoia/img/wallpaper.jpg
sudo cp ~/.dotfiles/bg.png /usr/share/lightdm-webkit/themes/sequoia/img/wallpaper.jpg

## GTK Theme and Icons
mkdir ~/.themes
mkdir ~/.icons

cp -r ~/.dotfiles/gtk-theme/theurge ~/.themes/theurge
cp -r ~/.dotfiles/gtk-theme/theurge-papirus ~/.icons/theurge-papirus

# Clone /etc/gtk-3.0/settings.ini
sudo cp ~/.dotfiles/etc/gtk-settings.ini /etc/gtk-3.0/settings.ini

## BSPWM
# Clone ~/.config/bspwm/bspwmrc ~/.config/sxhkd/sxhkdrc
mkdir -p ~/.config/bspwm
mkdir -p ~/.config/sxhkd

cp ~/.dotfiles/config/bspwmrc ~/.config/bspwm/bspwmrc
cp ~/.dotfiles/config/sxhkdrc ~/.config/sxhkd/sxhkdrc

## XDG
sudo xbps-install xdg-user-dirs xdg-utils xrdb

# Clone /etc/xdg/user-dirs.defaults
sudo cp ~/.dotfiles/etc/user-dirs.defaults /etc/xdg/user-dirs.defaults

# Update xdg dirs
xdg-user-dirs-update

## Xorg touchpad settings
sudo mkdir -p /etc/X11/xorg.conf.d
sudo cp ~/.dotfiles/etc/touchpad.conf /etc/X11/xorg.conf.d/30-touchpade.conf

## URXVT
# Clone .Xresources
cp ~/.dotfiles/.Xresources ~/.Xresources

# Merge .Xresources
xrdb ~/.Xresources

## Neofetch
# Install Neofetch
sudo xbps-install neofetch

# Copy ascii art logo to .logo
cp ~/.dotfiles/logo ~/.logo

## Rofi
sudo xbps-install rofi

# Clone rofi config and theme
mkdir -p ~/.config/rofi
mkdir -p ~/.local/share/rofi/themes/

cp ~/.dotfiles/config/rofi.rasi ~/.config/rofi/config.rasi
cp ~/.dotfiles/local/magelight.rasi ~/.local/share/rofi/themes/magelight.rasi

### Additional Software
## Network Manager
sudo xbps-install NetworkManager
sudo ln -s /etc/sv/NetworkManager /var/service

# Disable wpa_supplicant
sudo rm /var/service/wpa_supplicant

## screenshooter
sudo xbps-install xfce4-screenshooter

## Lock screen
sudo xbps-install i3lock-fancy

## Clone .emacs
cp ~/.dotfiles/.emacs ~/.emacs

## xfce4-panel
sudo xbps-install xfce4-panel xfce4-battery-plugin xfce4-pulseaudio-plugin network-manager-applet

# clone ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml
cp ~/.dotfiles/config/xfce4-panel.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

## Pipewire
sudo xbps-install pipewire pamixer
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo cp /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo cp /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

## Firefox
sudo xbps-install firefox

## Gomuks
sudo xbps-install gomuks

## Keepass
sudo xbps-install keepassxc

## Scheme installs
sudo xbps-install chicken chicken-devel guile

# Guile support for chicken
chicken-install -s apropos chicken-doc srfi-18
cd `csi -e '(import (chicken platform)) (display (chicken-home))(newline)'`
sudo curl https://3e8.org/pub/chicken-doc/chicken-doc-repo-5.tgz | sudo tar zx
cd ~

sudo reboot
