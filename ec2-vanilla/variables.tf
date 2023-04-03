
variable "region" {
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

   default = "t2.large"

}
variable "cpu_core" {

  default = 2 

}
variable "key_name" {
  type = string

}

variable "subid" {
  type = string
}

variable "sec_name" {
 default = "rt" 

}
variable "user_data" {

  default = "./user1.sh"

}
variable "vol_size" {

  default = 10 

}

variable "vpcid" {
  type = string
}
