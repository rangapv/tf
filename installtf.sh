#!/bin/bash
#run this script as ./installtf.sh 1.3.7
set -E
instf() {

if [ "$#" -eq 0 ]
then
	echo "No terraform version mentioned"
fi

ver="$@"

echo "ver is $ver"

inwgzip=`sudo apt-get -y install wget unzip` 

sget=`wget https://releases.hashicorp.com/terraform/$ver/terraform_${ver}_linux_amd64.zip`
szip=`sudo unzip ./terraform_${ver}_linux_amd64.zip -d /usr/local/bin/`

echo "$(terraform -v)"

}


versionchk () { 
tf1=`terraform version`
tf1s="$?"
tf2=`which terraform`
tf2s="$?"

if [[ ($tf1s -eq  0) && ($tf2s -eq 0) ]]
then
	echo "$tf1 \n $tf2\n"
else
        echo "No terraform installed/found"
	echo "To install the version 1.3.7 press enter or ENTER the required vrsion number"
	read tg
	#read -s -N 1 -t 1 tg
        if [ "$tg" ==  $'\0A' ]
	then
		set -- "1.3.7"
        fi
       instf $1
fi

}


 echo "Run this script as ./isstalltf.sh 1.3.7"

 versionchk
