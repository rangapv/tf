
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
type = string
}

variable "ins_type" {

   default = "t2.large"

}

variable "cpu_core" {

  default = 2 

}

variable "key_name" {

  default = "AldoCloudKEY"

}
variable "keypath" {

  type = string 

}

variable "server_names" {

default = [ "k8smaster11", "k8sworker11", "k8sworker12" ]

}


variable "user_data" {

  default = "./user1.sh"

}


variable "public_snets" {

type = string

}
variable "public_subnets" {

type = string

}

variable "vol_size" {

  default = 10 

}
