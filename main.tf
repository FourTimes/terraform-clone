module "first-instance" {
  source               = "./module/aws-ec2-instance"
  ami                  = "ami-0aef6aba2189944a9"
  availability_zone    = "ap-southeast-1a"
  iam_instance_profile = "AdminSSMFullAccess"
  instance_type        = "c4.xlarge"
  key_name             = "pmp-stock-downloader-1"
  subnet_id            = "subnet-01b1922b90cbbb422"
  vpc_id               = "vpc-0321a564ad761c349"
  security_group_name  = "PMP-SG-Stock-Downloader-1"
  additional_tags = {
    "Application" = "PMP"
    "Module"      = "REAPP"
    "Name"        = "AW-SE1PWREAPP01"
    "Owner"       = "Myo"
    "Stack"       = "Prod"
    "Type"        = "Instance"
  }

  ingress_rule = {
    "3389" = ["sg-07124f269b5937fc0"]
  }

}

module "second-instance" {
  source               = "./module/aws-ec2-instance"
  ami                  = "ami-0f0eb67421c410761"
  availability_zone    = "ap-southeast-1a"
  iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
  instance_type        = "c4.xlarge"
  key_name             = "pmp-stock-wcfapi"
  subnet_id            = "subnet-01b1922b90cbbb422"
  vpc_id               = "vpc-0321a564ad761c349"
  security_group_name  = "PMP-SG-Stock-WCFAPI_New"
  additional_tags = {
    "Application" = "PMP"
    "Module"      = "REAPI"
    "Name"        = "AW-SE1PWREAPI01"
    "Owner"       = "Myo"
    "Stack"       = "Prod"
    "Type"        = "Instance"
  }
  ingress_rule = {
    "3389" = ["sg-07124f269b5937fc0"]
    "80"   = ["sg-00c5ce496cd683c57", "sg-0ca1e6872033f025a"]
  }
}


module "third-instance" {
  source               = "./module/aws-ec2-instance"
  ami                  = "ami-08c16c182fccbb3ac"
  availability_zone    = "ap-southeast-1a"
  iam_instance_profile = "AdminSSMFullAccess"
  instance_type        = "c4.xlarge"
  key_name             = "pmp-stock-webserver"
  subnet_id            = "subnet-01b1922b90cbbb422"
  vpc_id               = "vpc-0321a564ad761c349"
  security_group_name  = "PMP-SG-Stock-Webserver_new"
  additional_tags = {
    "Application" = "PMP"
    "Module"      = "REWEB"
    "Name"        = "AW-SE1PWREWEB01"
    "Owner"       = "Myo"
    "Stack"       = "Prod"
    "Type"        = "Instance"
  }
  ingress_rule = {
    "3389" = ["sg-07124f269b5937fc0"]
    "80"   = ["sg-00c5ce496cd683c57"]
  }
}
