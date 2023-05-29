#create ec2 instance


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
  # security_groups = [ var.sec_name ]
  user_data = "${file("./user1.sh")}"
  #volume_size = var.vol_size
  subnet_id = var.sub_id
  root_block_device {
    volume_size = var.vol_size
  }
  vpc_security_group_ids = [ var.sec_id, ] 
  tags = {
    Name = "k8sMaster1"
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = self.public_ip
    private_key = file("${path.module}/Aldo3.pem") 
 }

 provisioner "remote-exec" {

   inline = [
    "#!/bin/bash",  
    "mkdir simplek8s",
    "cd simplek8s",
    "git init; git pull https://github.com/rangapv/Simplek8s.git",
    "./simpleccm.sh ${var.accesskey} ${var.secretkey}"
    ]
    # on_failure = continue
 } 

}


output "instances" {
  value       = "${aws_instance.app_server.*.public_ip}"
  description = "PrivateIP address details"
}

output "file" {
  value = fileexists("${path.module}/Aldo3.pem")
  description = "To check if file is there"
}
