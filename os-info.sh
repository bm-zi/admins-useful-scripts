#!/bin/bash

# Author: Bahram Z.
# This script logs system information into a log file (info.log).

# You can add any command that might be useful to the list of the 
# commands defined in array cmdslist and if needed customize the 
# outputs using tools like 'grep', 'sed', 'awk' ... inside of the
# case statement below.



   cat /dev/null > info.log
   
   exec >> >(tee -a info.log)
   exec 2>&1
  
cmdslist=(
'sudo lshw -short'
'sudo lscpu'
'sudo lsblk'
'sudo lspci -v'
'sudo fdisk -l'
'sudo dmidecode -t memory'
'sudo dmidecode -t processor'
'sudo dmidecode -t system' 
)


cmdHeader() {
   n=$1
   h=$(($1+1))
   echo " _______________________________ $h __________________________________"
   echo '||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'
   echo '||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||'
   echo 
   echo  "\$ ${cmdslist[$n]}"
}


for ((i = 0; i < ${#cmdslist[@]}; i++)); do

   case $i in
		3)
			cmdHeader $i
			${cmdslist[$i]} | sed  -n '/^[[:digit:]]\|Kernel modules/p'  
		;;				
		7)    
			cmdHeader $i  
			${cmdslist[$i]} | head -15
		;;
		*)
			cmdHeader $i
			${cmdslist[$i]}
		;;
   esac
   
done
