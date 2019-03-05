#!/bin/bash

# Start a vm on KVM server and automate login to vm server,
# while vm can be logged in passwordless.

if [ $# -eq 0 ]; then

echo "
 Warning:
 Provide a virtual machine name as the argument. 

 Format:
 vmstart [virtual_machin_name]
"
exit 0;
fi


vm=$1

clear
sudo virsh start $vm 


CONNECTED=1

while [[ $CONNECTED != 0 ]]; do
    ping -c30 $vm
    CONNECTED=$?
    if [[ $CONNECTED == 0 ]] ; then
        ssh root@$vm
    else
        clear
        echo "Check the status of virtual machine $vm  ..."
    fi
done
