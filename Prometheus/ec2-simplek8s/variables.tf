
variable "region" {
  default = "us-east-2"
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

   default = "t2.xlarge"

}

variable "cpu_core" {

  default = 2 

}

variable "key_name" {
  default = "YCStartup2018" 

}
variable "keypath" {

  type = string 

}

variable "server_names" {

default = [ "k8smaster14", "k8sworker14" ]

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

  default = 30 

}
