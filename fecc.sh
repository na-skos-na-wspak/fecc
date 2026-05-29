#!/usr/bin/env sh
# Grabs info
USER=$(whoami)
# Grabs the distro name off of
OS=$(cat /etc/os-release | awk -F'[/"]' '/PRETTY_NAME="/ {print $2}')
# Grabs Hostname
HOSTNAME=$(cat /proc/sys/kernel/hostname)
# Waz ur kernel
KERNEL=$(uname -r | cut -d- -f1)
# Pulls days, hours, and minutes from uptime
UPTIME=$(awk '{print int($1/86400)"d "int($1%86400/3600)"h "int(($1%3600)/60)"m "}' /proc/uptime)
if [ -e /etc/ipkg/installed ]; then
	PKGS=$(cat /etc/ipkg/installed | wc -l)
else
	PKGS=2
fi
# Gets the used memory out of the total
MEM=$(free --mega | awk '/Mem:/{print $3"m /",$2"m"}')

# Colours for the output
# yellow
y='\e[0;33m'
# red
r='\e[0;31m'
# purple
p='\e[0;35m'
# cyan
c='\e[0;34m'
# no colour
nc='\e[0m'
# bold
bo='\e[1m'

# Prints the info
printf "$c$bo$USER\a@$HOSTNAME$nc
$y$bo\aos$nc     $OS
$y$bo\akernel$nc $KERNEL
$y$bo\auptime$nc $UPTIME
$y$bo\apkgs$nc   $PKGS
$y$bo\amem$nc    $MEM
$r🭹🭹🭹🭹🭹🭹🭹🭹$y🭹🭹🭹🭹🭹🭹🭹🭹$p🭹🭹🭹🭹🭹🭹🭹🭹$nc
"
