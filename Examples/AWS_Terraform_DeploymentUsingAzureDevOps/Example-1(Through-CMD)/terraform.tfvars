# You need to upload this file at azure pipelines/library/securefiles section and add the permissions to access this file to azure pipelines
#values passing from here
vpc_name              = "uat-vpc"
vpc_cidr_block        = "10.1.0.0/16"
pub_subnet_count      = "1"
pub_subnet_cidr_block = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
pvt_subnet_count      = "1"
pvt_subnet_cidr_block = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
aws_access_key_id     = "<>"
aws_secret_access_key = "<>"
aws_region            = "us-east-1"
