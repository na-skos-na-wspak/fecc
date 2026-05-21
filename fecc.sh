#!/usr/bin/env sh
# Grabs info
USER=$(whoami)
# Grabs the distro name off of
OS=$(cat /etc/os-release | awk -F'[/"]' '/PRETTY_NAME="/ {print $2}')
HOSTNAME=$(cat /proc/sys/kernel/hostname)
KERNEL=$(uname -r)
UPTIME=$(uptime -p | cut -d' ' -f2-)
if [ -e /etc/ipkg/installed ]; then
	PKGS=$(cat /etc/ipkg/installed | wc -l)
else
	PKGS=2
fi
MEM1=$(free --mega | awk '/Mem:/ {print $3}')
MEM2=$(free --mega | awk '/Mem:/ {print $2}')

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

printf "$bo$c$USER\a@$HOSTNAME$nc
$y$bo\aos$nc     $OS
$y$bo\akernel$nc $KERNEL
$y$bo\auptime$nc $UPTIME
$y$bo\apkgs$nc   $PKGS
$y$bo\amem$nc    $MEM1\am / $MEM2\am
$r🭹🭹🭹🭹🭹🭹🭹🭹🭹$y🭹🭹🭹🭹🭹🭹🭹🭹🭹$p🭹🭹🭹🭹🭹🭹🭹🭹🭹$nc
"
