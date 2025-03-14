#! /bin/bash
#./clean.sh download archives temp
echo Bash script starting at: $(date '+%Y-%m-%dT%H:%M:%S.%3N%z')
echo Script full path: $(realpath -s "clean.sh")

downloadDir=$1
green='\033[0;32m'
clear='\033[0m'
echo "Removing download directory "$1
rm -r $1
echo -e $green"Done"$clear

echo "Deleting old archives from "$2
cd $2'/'
ls -t | tail -n +3 | xargs rm
echo -e $green"Done"$clear
cd ..

echo "Emptying temporary directory"$3
cd $3'/'
rm *
echo -e $green"Done"$clear

echo Bash script ending at: $(date '+%Y-%m-%dT%H:%M:%S.%3N%z')
echo "Bye"

