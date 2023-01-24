module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "2.0.1"

  key_name = "YCStartup2023"
  public_key = "ssh-rsa AAAAB3NzaC1y************************************************************fQrIJ9/ imported-openssh-key"
}
