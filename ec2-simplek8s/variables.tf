
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

   default = "ami-0735c191cf914754d"
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

  default = "launch-wizard-1"
}

variable "sec_id" {

 default = "sg-eaf37d92"

}

variable "user_data" {

  default = "./user1.sh"

}

variable "sub_id" {

 default = "subnet-e44865bc"

}


variable "vol_size" {

  default = 10 

}
