#!/bin/bash

mydf () {
clear
df -h | head -1
df -h | grep sda

echo
echo "Space used by home directory"
sudo du -sh ~

echo
echo "Top largest directories under home directory "
sudo du -aSh ~/* | sort -rh | head -5

echo
echo "Top largest files only, under home directory"
sudo find ~ -type f -exec du -Sh {} + | sort -rh | head -n 5
}

mydf
