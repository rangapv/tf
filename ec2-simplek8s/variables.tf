
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

variable "sec_name" {
type = string
}

variable "sec_id" {
type = string
}


variable "user_data" {

  default = "./user1.sh"

}

variable "sub_id" {
type = string

}


variable "vol_size" {

  default = 10 

}
