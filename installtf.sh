#!/bin/bash
#run this script as ./installtf.sh 1.3.7
set -E
instf() {

if [ "$#" -eq 0 ]
then
	echo "No terraform version mentioned"
	exit
fi

ver="$@"

echo "ver is $ver"

inwgzip=`sudo apt-get -y install wget unzip` 

sget=`wget https://releases.hashicorp.com/terraform/$ver/terraform_${ver}_linux_amd64.zip`
szip=`sudo unzip ./terraform_${ver}_linux_amd64.zip -d /usr/local/bin/`

echo "$(terraform -v)"

}

instf $1
