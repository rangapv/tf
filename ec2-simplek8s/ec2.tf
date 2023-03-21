#create ec2 instance


provider "aws" {
  region = var.region 
  access_key = var.accesskey 
  secret_key = var.secretkey 
}


resource "aws_instance" "app_server" {
  depends_on = [
       aws_subnet.publicsubnetstf,
       aws_security_group.vpc_security_tf
     ]
  count = length(var.server_names)
  #name  = var.server_names[count.index]

  ami           = var.ami 
  instance_type = var.ins_type 
  associate_public_ip_address = "true"
  #cpu_core_count = var.cpu_core
  key_name = var.key_name
  # security_groups = [ var.sec_name ]
  user_data = "${file("./user1.sh")}"
  #volume_size = var.vol_size
  subnet_id = aws_subnet.publicsubnetstf.id 
  root_block_device {
    volume_size = var.vol_size
  }
  vpc_security_group_ids = [ aws_security_group.vpc_security_tf.id, ] 
  tags = {
    Name = var.server_names[count.index]
  }

  connection {
    type     = "ssh"
    user     = "ubuntu"
    host     = self.public_ip
    private_key = file("${path.module}/Aldo3.pem") 
  }


  provisioner "file" {
    source      = "./remote.sh"
    destination = "/home/ubuntu/remote.sh"
  }

  provisioner "file" {
    source      = "./Aldo3.pem"
    destination = "/home/ubuntu/Aldo3.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/remote.sh",
      "/home/ubuntu/remote.sh ${var.accesskey} ${var.secretkey}",
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
