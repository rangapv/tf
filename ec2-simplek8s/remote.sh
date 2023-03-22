#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >/dev/null 2>&1
tag1s=1
tag2s=1


awscli() {
awse1=`which aws`
awse1s="$?"
if [[ (( $awse1s -ne 0 )) ]]
then

awscli1=`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" >/dev/null 2>&1`

awscli2=`sudo apt install unzip -y >/dev/null 2>&1`

awscli3=`unzip ./awscliv2.zip >/dev/null 2>&1`

awscli4=`sudo ./aws/install >/dev/null 2>&1`
fi

awsjq=`which jq`
awsjqs="$?"
if [[ (( $awsjqs -ne 0 )) ]]
then
`sudo $cm1 -y install jq >/dev/null 2>&1`
fi

}


cont() {
acid="$1"
secid="$2"
export AWS_ACCESS_KEY_ID=${acid}
export AWS_SECRET_ACCESS_KEY=${secid}
#sudo $cm1 -y install awscli >/dev/null 2>&1
awscli
}

hid() {

ecm=`which ec2-metadata`
ecms="$?"
if [[ (( $ecms -ne 0 )) ]]
then
wget http://s3.amazonaws.com/ec2metadata/ec2-metadata
chmod u+x ec2-metadata
`sudo mv ./ec2-metadata /usr/local/bin/`
fi
str23=`ec2-metadata -i`
str234=`ec2-metadata -i | awk '{split($0,a," "); print a[2]}'`
str233=`ec2-metadata -z | awk '{split($0,a," "); print a[2]}' | sed 's/.$//'`
str231=`ec2-metadata -z | awk '{split($0,a," "); print a[2]}'`
str232=`echo $str23 | awk '{split($0,a," "); print a[2]}'`
#echo "region $str231"
#echo "id $str232"
#echo "str232 is $str233"

}

displaytag() {
tag1=`aws ec2 describe-tags --region $str233 --filter "Name=resource-id,Values=$str234" | grep 'master'`
#tag1=`aws ec2 describe-tags --region $str233 --filter "Name=resource-id,Values=$str234" | grep 'master' | awk '{split($0,a," "); print a[2]}'| grep -oh '\w*[(a-z)]*\w*'`
tag1s="$?"
echo "tag1s is $tag1s"
#tag2=`aws ec2 describe-tags --region $str233 | grep 'worker' | awk '{split($0,a," "); print a[2]}'| grep -oh '\w*[(a-z)]*\w*'` 
#tag2=`aws ec2 describe-tags --region $str233 --filter "Name=resource-id,Values=$str232"| grep 'worker' `
tag2=`aws ec2 describe-tags --region $str233 --filter "Name=resource-id,Values=$str234" | grep 'worker'`
tag2s="$?"
echo "tag2s is $tag2s"
#tag1=`aws ec2 describe-tags --region $str233 --filter "Name=resource-id,Values=$str232" --filter "key=Name" `
#echo "the tag is $tag1 and status is $tag1s"
#echo "the tag is $tag2 and status is $tag2s"
}

master() {

mc1=`mkdir simplek8s`
mc2=`cd ./simplek8s;git init; git pull https://github.com/rangapv/Simplek8s.git;./simpleccm.sh "$1" "$2"`
}


master_publicip() {

de=`aws ec2 describe-instances --region $str233`
#echo "$de"
de2=`aws ec2 describe-instances --region $str233 --filter "Name=tag:Name,Values=*master*" | grep "PublicIpAddress" | awk '{split($0,a," "); print a[2]}'| grep -oh '\w*[(0-9\.)]*\w*'`
echo "DE2 is $de2"
}


worker() {

wc1=`mkdir simplek8s`
wc2=`cd ./simplek8s;git init; git pull https://github.com/rangapv/Simplek8s.git;./simplenodeccm.sh "$1" "$2"`
}


worker_scp() {
src1="$1"
dest1="$2"

waldo=`chmod 400 /home/ubuntu/Aldo3.pem`
wmkdir=`mkdir -p /home/ubuntu/.kube/`
wscp=`scp -o StrictHostKeyChecking=accept-new -i /home/ubuntu/Aldo3.pem ubuntu@$de2:"$src1"  "$dest1"`
#wscp2=`scp -o StrictHostKeyChecking=accept-new -i /home/ubuntu/Aldo3.pem ubuntu@$de2:/home/ubuntu/simplek8s/flag.txt /home/ubuntu/simplek8s/`
#wscp=`scp -o StrictHostKeyChecking=accept-new -i /home/ubuntu/Aldo3.pem ubuntu@$de2:/home/ubuntu/.kube/config /home/ubuntu/.kube/`
#echo "wscp is $wscp"

}

worker_join() {
fileflag="$3"
sedo=`chmod 777 "$fileflag"`
f1=`cat "$fileflag" | grep 'kubeadm join'`
f2=`cat "$fileflag" | grep 'kubeadm join' | grep -o "[^ ]*$"`
tg="&"
gt="sudo "
if [[ "$f2" = "\\" ]]
then
f3=`cat "$fileflag" | grep -A 2 'kubeadm join'`
#echo "f2 is $f3"
f4=$( echo $f3 | xargs tr -s ' ')
f44=$gt$f4$tg
#echo "f4 is $f4"
#echo "f44 is $f44"
else
f44=$gt$f2$tg
fi
#echo "$f44"
join=`${f44}`
joins="$?"

}

while_check() {
     
filechk="$1"
funcexe1="$2"
funcexe2="$3"
acc1="$4"
sec1="$5"
      	while :
        do
          if [ ! -f "$filechk"  ]
          then
               echo "File not copied yet"
               $funcexe1 $filechk $filechk
          else
               echo "Config file copied to the worker node from the master..proceed with components installs"
               $funcexe2 $acc1 $sec1 $filechk
               break
          fi
        done
}


cont "$1" "$2"
hid
displaytag
master_publicip

if [[ (( $tag1s -eq 0 )) ]]
then
	echo "This is the Master, Install K8s master components"
        master "$1" "$2"
 
elif [[ (( $tag2s -eq 0 )) ]]
then
	echo "This is the Worker, Install k8s worker components"
        
	while_check "/home/ubuntu/.kube/config"  "worker_scp" "worker"  "$1" "$2"
       
       	while_check "/home/ubuntu/simplek8s/flag.txt" "worker_scp" "worker_join"  "$1" "$2"

else
	echo "Could not determine Master or Node so no k8s components are installed ..exiting k8s install"
fi

