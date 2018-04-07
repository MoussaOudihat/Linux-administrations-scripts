
###################################################################
# author: MOUSSA OUDIHAT                                          #
# Name : linux script to monitor network, uptime, disk usage ..etc#
################################################################### 





#! /bin/bash

# clear the screen
clear
# Unset Variables

unset os architecture krnlrelease ipintern ipextern nameserver loadavg
 
# Check internet connection
ping -c 1 google.com &> /dev/null && echo -e '\E[37m'"Internet:"'\E[0;32m' "Connected" || echo -e '\E[37m'"Internet:" '\E[0;32m'"Disconnected"

# OS Type
os=$(uname -o)
echo -e '\E[37m'"Operating System Type :" '\E[0;32m'$os

# OS Release Version and Name
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease
echo -n -e '\E[0;37m' "OS Name :" '\E[0;32m'&& cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\"
echo -n -e '\E[37m'"OS Version :" '\E[0;32m'&& cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\"

# Architecture
architecture=$(uname -m)
echo -e '\E[37m'"Architecture :" '\E[0;32m'$architecture

# Kernel Release
krnlrelease=$(uname -r)
echo -e '\E[37m'"Kernel Release :" '\E[0;32m'$krnlrelease

# hostname
echo -e '\E[37m'"Hostname :" '\E[0;32m'$HOSTNAME

# Check Internal IP
ipintern=$(hostname -I)
echo -e '\E[37m'"Internal IP :"'\E[0;32m' $ipintern

# Check External IP
ipextern=$(curl -s ipecho.net/plain;echo)
echo -e '\E[37m'"External IP :'\E[0;32m'"$ipextern

# Check DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo -e '\E[37m'"Name Servers :'\E[0;32m'"$nameservers 

# Check Logged Users
who>/tmp/who
echo -e '\E[37m'"Logged In users :" '\E[0;32m' && cat /tmp/who 

# Check RAM and SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo -e '\E[37m'"Ram Usages :"'\E[0;32m'
cat /tmp/ramcache | grep -v "Swap"
echo -e '\E[37m'"Swap Usages :"'\E[0;32m'
cat /tmp/ramcache | grep -v "Mem"

# Check Disk Usages
df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage
echo -e '\E[37m'"Disk Usages :"'\E[0;32m'
cat /tmp/diskusage

# Check Load Average
loadavg=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e '\E[37m'"Load Average :"'\E[0;32m' $loadavg

# Check System Uptime
tuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e '\E[37m'"System Uptime Days/(HH:MM) :"'\E[0;32m' $tuptime

# Unset Variables
unset os architecture krnlrelease ipintern ipextern nameserver loadavg

# Remove Temporary Files
rm /tmp/osrelease /tmp/who /tmp/ramcache /tmp/diskusage

