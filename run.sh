#! /bin/bash
#./run.sh urls.txt download archives

urls=$(grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" $1)
readarray urls < <(grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" $1)

echo Bash script starting at: $(date '+%Y-%m-%dT%H:%M:%S.%3N%z')
echo Script full path: $(realpath -s "run.sh")
#rlsm -r temp
mkdir -p temp

blue='\033[0;34m'
green='\033[0;32m'
clear='\033[0m'

for url in "${urls[@]}"
do
echo -n -e "Downloading $blue${url}$clear"
curl --silent --output "temp/${url:43:7}" ${url}
curl -I --silent --output "temp/${url:43:7}.headers" ${url}
echo -e "${green}Done${clear}"
done

mkdir -p $2
echo Copying JSON files from temp to $2
#cd temp
cp -r temp/* $2


sed -i '1 i ###de.json.headers:' temp/de.json.headers
sed -i '1 i ###fr.json.headers:' temp/fr.json.headers
sed -i '1 i ###es.json.headers:' temp/es.json.headers
cat temp/de.json.headers temp/fr.json.headers temp/es.json.headers > ${2}'/headers.txt'
echo -e $green"Done"$clear

echo Compressing all files in $2 to $3
mkdir -p $3
formattedDateTime=$(date '+%Y-%m-%dT%H-%M-%S')
tar cf $3/$formattedDateTime.tar.gz -I 'xz -9e' $2
echo -e $green'Done'$clear '(archive file name: '$formattedDateTime'.tar.gz)'

echo Bash script ending at: $(date '+%Y-%m-%dT%H:%M:%S.%3N%z')
echo "Bye" 
