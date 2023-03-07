
variable "region" {

  default = "us-west-2"

}

variable "accesskey" {
  type = string
  sensitive = true
}

variable "secretkey" {
  type = string
  sensitive = true
}

variable "ami" {

  default = "ami-097a2df4ac947655f"

}

variable "ins_type" {

   default = "t2.large"

}

variable "cpu_core" {

  default = 2 

}
variable "iam_instance_profile" {

  default = "k8srole"

}
variable "key_name" {

  default = "AldoCloudKEY"

}

variable "sec_name" {

  default = "launch-wizard-1"

}
variable "user_data" {

  default = "./user1.sh"

}
variable "vol_size" {

  default = 10 

}
