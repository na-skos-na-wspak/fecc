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
# black
b='\e[0;90m'
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
printf "$b$bo    ___     
$bo   ($nc$bo\a..$b$bo |    $c$bo\a$USER\a@$HOSTNAME$nc
$b$bo   ($y$bo\a<>$b$bo |    $y$bo\aos$nc     $OS
$b$bo  /$nc$bo __$b$bo  \   $y$bo\akernel$nc $KERNEL
$b$bo ($nc$bo /  \ $b$bo\a/|  $y$bo\auptime$nc $UPTIME
$y$bo\a_$b$bo/\ $nc$bo\a__)$b$bo\a/$y$bo\a_$b$bo\a)  $y$bo\apkgs$nc   $PKGS
$y$bo\a\/$b$bo\a-____$y$bo\a\/$nc   $y$bo\amem$nc    $MEM
$r🭹🭹🭹🭹🭹🭹🭹🭹🭹🭹🭹$y🭹🭹🭹🭹🭹🭹🭹🭹🭹🭹🭹$p🭹🭹🭹🭹🭹🭹🭹🭹🭹🭹🭹$nc

"
