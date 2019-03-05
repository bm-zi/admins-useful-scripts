#!/bin/bash


function cmd1 (){ 
echo "Capacity(GB) Allocation(GB) Physical(GB)   Domain"
echo "................................................."
for i in `sudo virsh list --all --name`; do 
(sudo virsh domblkinfo $i --all|grep -v Target|grep -v "\-\-\-\-"| grep -v ^$|awk '{printf "%0d %12d %14d", $2/1073741824 , $3/1073741824 , $4/1073741824 }') 2>/dev/null 
printf "%20s\n" $i 
done
}


function cmd2 (){ 
for i in `sudo virsh list --all --name`; do
(sudo virsh domblkinfo $i --all|grep -v Target| grep -v "\-\-\-\-"| grep -v ^$|awk '{print ""$2/1073741824"  "$3/1073741824"  "$4/1073741824""}') 2>/dev/null
done
}

clear
sudo virsh list --all
cmd1 
cap=$(cmd2 | awk '{SUM+=$1}END{print SUM}')
aloc=$(cmd2 | awk '{SUM+=$2}END{print SUM}')
phys=$(cmd2 | awk '{SUM+=$3}END{print SUM}')

echo; 
echo "  Total capacity: $cap GB"
echo "Total allocation: $aloc GB"
echo "  Total physical: $phys GB"
