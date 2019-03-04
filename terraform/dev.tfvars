aws = {
  access_key = ""
  secret_key = ""

  access_key_prd = ""
  secret_key_prd = ""

  region         = "ap-northeast-1"
  region_sub     = "us_east_1"
}

env = {
  zone_a = "stg"
  zone_c = "stg"
  zone_d = "dev"
}

eip = {
  bastion_id     = "eipalloc-00d1999e9xxxxxxxx"
  nat_gateway_id = "eipalloc-0c3dafe74xxxxxxxx"
}

vpc = {
  cidr_vpc            = "10.10.0.0/16"
  cidr_front_a        = "10.10.10.0/24"
  cidr_front_c        = "10.10.11.0/24"
  cidr_front_d        = "10.10.12.0/24"
  cidr_public_a       = "10.10.20.0/24"
  cidr_public_c       = "10.10.21.0/24"
  cidr_public_d       = "10.10.22.0/24"
  cidr_private_web_a  = "10.10.30.0/24"
  cidr_private_web_c  = "10.10.31.0/24"
  cidr_private_web_d  = "10.10.32.0/24"
  cidr_private_data_a = "10.10.40.0/24"
  cidr_private_data_c = "10.10.41.0/24"
  cidr_private_data_d = "10.10.42.0/24"
}

ec2 = {
  bastion_name = "bastion"
  bastion_type = "t2.micro"
  bastion_ip   = "10.10.22.22"
}

