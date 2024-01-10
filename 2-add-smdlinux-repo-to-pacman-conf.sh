#!/bin/bash
set -e

######################## Variables #######################
#
# b=bold u=underline bl=black r=red g=green
# y=yellow bu=blue m=magenta c=cyan w=white
# endc=end-color enda=end-argument
b='\033[1m'
u='\033[4m'
bl='\E[30m'
r='\E[31m'
g='\E[32m'
y='\E[33m'
bu='\E[34m'
m='\E[35m'
c='\E[36m'
w='\E[37m'
endc='\E[0m'
enda='\033[0m'
version="20230131"

# https://wiki.archlinux.org/index.php/Pacman/Package_signing#Adding_unofficial_keys
echo
echo -e " [${g}✔${endc}]::[${g}${b}Adding SMD-Linux Keys${enda}${endc}]"
echo

echo -e " [${g}✔${endc}]::[${g}${b}Receiving Key for SMD-Linux Packages${enda}${endc}]"
sudo pacman-key --recv-keys BB31837564255477
echo -e " [${g}✔${endc}]::[${g}${b}Verify Fingerprint${enda}${endc}]"
sudo pacman-key --finger BB31837564255477
echo -e " [${g}✔${endc}]::[${g}${b}Local Sign Imported Key${enda}${endc}]"
sudo pacman-key --lsign-key BB31837564255477
echo -e " [${g}✔${endc}]::[${g}${b}Refresh Keys${enda}${endc}]"
sudo pacman-key --refresh-keys

echo
echo -e " [${g}✔${endc}]::[${g}${b}Added SMD-Linux Keys${enda}${endc}]"
echo

echo
echo -e " [${g}✔${endc}]::[${g}${b}Adding SMD-Linux Repos${enda}${endc}]"
echo

echo '
#[smdlinux_repo_testing]
#SigLevel = Required DatabaseOptional
#Server = https://repo.sethdawson.me/archlinux/$repo/$arch

[smdlinux_repo]
SigLevel = Required DatabaseOptional
Server = https://repo.sethdawson.me/archlinux/$repo/$arch

[smdlinux_repo_3party]
SigLevel = Required DatabaseOptional
Server = https://repo.sethdawson.me/archlinux/$repo/$arch
' | sudo tee --append /etc/pacman.conf

sudo pacman -Syyu

echo
echo -e " [${g}✔${endc}]::[${g}${b}SMD-Linux GPG Keys and Repository Added${enda}${endc}]"
echo
echo -e " ${bu}SMD-Linux Installation Scripts Version${b} $version ${enda} ${endc}"
