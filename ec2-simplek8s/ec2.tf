#create ec2 instance

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
  required_version = ">= 1.2.0"
}


provider "aws" {
  region = var.region 
  access_key = var.accesskey 
  secret_key = var.secretkey 
}


resource "aws_instance" "app_server" {
  ami           = var.ami 
  instance_type = var.ins_type 
  associate_public_ip_address = "true"
  #cpu_core_count = var.cpu_core
  key_name = var.key_name
  security_groups = [ var.sec_name, ]
  user_data = "${file("./user1.sh")}"
  #volume_size = var.vol_size
  root_block_device {
    volume_size = var.vol_size
  }
 
  provisioner "remote-exec" {

  inline = [
    "#!/bin/bash",  
    "mkdir simplek8s; cd simplek8s",
    "git init; git pull https://github.com/rangapv/Simplek8s.git",
    "./simpleccm.sh ${var.accesskey} ${var.secretkey}"
    ]

  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = self.public_ip
    private_key = "${file("./Aldo.pem")}" 
    #private_key = "${var.mykey}" 
  }

}

  tags = {
    Name = "k8sMaster1"
  }
}


output "instances" {
  value       = "${aws_instance.app_server.*.public_ip}"
  description = "PrivateIP address details"
}

