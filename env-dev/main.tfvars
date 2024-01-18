env = "dev"
tags = {
    company = "xyz co"
    bu_unit = "Ecommerce"
    project = "roboshop"
}

default_vpc_cidr = "172.31.0.0/16"
default_vpc_id = "vpc-012386a750941fd98"
default_route_table_id = "rtb-01d47609d1bb376b7"
account_id = "751177946459"

route53_zone_id = "Z043769343BOX5323WQF"
kms = "arn:aws:kms:us-east-1:751177946459:key/a67450bb-b04f-45c0-8406-5588122b350e"
certificate_arn = "arn:aws:acm:us-east-1:751177946459:certificate/f004e848-d847-45e8-b070-c290fb1b072c"


vpc = {
    main = {
            vpc_cidr_block = "10.11.0.0/16"
            public_subnet = ["10.11.0.0/24","10.11.1.0/24"]
            web_subnet = ["10.11.2.0/24","10.11.3.0/24"]
            app_subnet = ["10.11.4.0/24","10.11.5.0/24"]
            db_subnet = ["10.11.6.0/24","10.11.7.0/24"]
            azs_subnet = ["us-east-1a","us-east-1b"]
  }
}


rds = {
    main = {
    rds_allocated_storage =  20
    rds_engine = "mysql"
    rds_engine_version = "5.7.44"
    rds_instance_class = "db.t3.micro"
    parameter_group_family = "mysql5.7"
  }
}


