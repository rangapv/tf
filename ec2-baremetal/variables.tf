
variable "region" {
  default = "us-east-2"
}

variable "zone" {
  type = string
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
variable "rolearn" {

  type = string 
  default = "dummy"
}
variable "server_names" {

default = [ "k8smasternew1", "k8sworkernew1" ]

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

  default = 50 

}
