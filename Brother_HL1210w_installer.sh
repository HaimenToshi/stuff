#!/bin/sh
#sudo apt install gcc-multilib
#sudo apt install rpm
#sudo xbps-install void-repo-multilib-6_2
#sudo xbps-install -Sy
#sudo xbps-install gcc-multilib
#sudo xbps-install rpmextract
cd ~
mkdir hl1210w
cd hl1210w
wget http://download.brother.com/welcome/dlf101549/hl1210wlpr-3.0.1-1.i386.rpm
wget http://download.brother.com/welcome/dlf101548/hl1210wcupswrapper-3.0.1-1.i386.rpm
rpmunpack hl1210wlpr-3.0.1-1.i386.rpm
rpmunpack hl1210wcupswrapper-3.0.1-1.i386.rpm
#rpm2cpio hl1210wlpr-3.0.1-1.i386.rpm | cpio -idmv
#rpm2cpio hl1210wcupswrapper-3.0.1-1.i386.rpm | cpio -idmv
sudo mkdir -p /usr/share/cups/model/
sudo mkdir -p /usr/lib/cups/filter/
sudo cp hl1210wcupswrapper-3.0.1-1.i386/opt/brother/Printers/HL1210W/cupswrapper/brother-HL1210W-cups-en.ppd /usr/share/cups/model/brother-HL1210W-cups-en.ppd
sudo cp hl1210wcupswrapper-3.0.1-1.i386/opt/brother/Printers/HL1210W/cupswrapper/brother_lpdwrapper_HL1210W /usr/lib/cups/filter/brother_lpdwrapper_HL1210W
sudo cp -r hl1210wlpr-3.0.1-1.i386/opt/* /opt/
sudo cp hl1210wcupswrapper-3.0.1-1.i386/opt/brother/Printers/HL1210W/cupswrapper/brother_lpdwrapper_HL1210W /usr/lib/cups/filter/
sudo cp hl1210wcupswrapper-3.0.1-1.i386/opt/brother/Printers/HL1210W/cupswrapper/brother_lpdwrapper_HL1210W /usr/libexec/cups/filter/
