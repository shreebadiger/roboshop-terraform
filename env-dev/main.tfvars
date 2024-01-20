env = "dev"
tags = {
    company = "xyz co"
    bu_unit = "Ecommerce"
    project_name = "roboshop"
}

    default_vpc_cidr = "172.31.0.0/16"
    default_vpc_id = "vpc-012386a750941fd98"
    default_route_table_id = "rtb-01d47609d1bb376b7"
    account_id = "751177946459"

    route53_zone_id = "Z043769343BOX5323WQF"
    kms = "arn:aws:kms:us-east-1:751177946459:key/a67450bb-b04f-45c0-8406-5588122b350e"
    certificate_arn = "arn:aws:acm:us-east-1:751177946459:certificate/f004e848-d847-45e8-b070-c290fb1b072c"
    bastion_cidrs = ["172.31.46.123/32"]
    prometheus_cidrs = ["172.31.37.53/32"]


vpc = {
    main = {
    vpc_cidr_block = "10.11.0.0/16"
    public_subnet = ["10.11.0.0/24","10.11.1.0/24"]
    web_subnet = ["10.11.2.0/24","10.11.3.0/24"]
    app_subnet = ["10.11.4.0/24","10.11.5.0/24"]
    db_subnet = ["10.11.6.0/24","10.11.7.0/24"]
    azs_subnet = ["us-east-1a","us-east-1b"]
    internet = ["0.0.0.0/0"]
}
}


rds = {
    main = {
    allocated_storage =  20
    engine = "mysql"
    engine_version = "5.7.44"
    instance_class = "db.t3.micro"
    parameter_group_family = "mysql5.7"
  }
}

docdb = {
    main = {
    engine = "docdb"
    engine_version = "4.0.0"
    instance_class = "db.t3.medium"
    parameter_group_family = "docdb4.0"
    instance_count = 1
  }
}

elasticache = {
    main = {
    engine = "redis"
    engine_version = "6.2"
    node_type = "cache.t3.micro"
    parameter_group_family = "redis6.x"
    num_cache_nodes = 1
  }
}

rabbitmq = {
    main = {
    instance_type = "t3.small"
  }
}

app = {
      catalogue = {
        instance_type = "t3.small"
        instance_count = 1
        app_port = 8080
        app_subnet_name = "app_subnet"
        lb_subnet_name = "app_subnet"
        alb_name = "private"
        priority = 1
    }
      frontend = {
        instance_type = "t3.small"
        instance_count = 1
        app_port = 80
        app_subnet_name = "web_subnet"
        lb_subnet_name = "public_subnet"
        alb_name = "public"
        priority = 1
    }
      cart = {
        instance_type = "t3.small"
        instance_count = 1
        app_port = 8080
        app_subnet_name = "app_subnet"
        lb_subnet_name = "app_subnet"
        alb_name = "private"
        priority = 2
    }
      user = {
        instance_type = "t3.small"
        instance_count = 1
        app_port = 8080
        app_subnet_name = "app_subnet"
        lb_subnet_name = "app_subnet"
        alb_name = "private"
        priority = 3
    }
      shipping = {
        instance_type = "t3.small"
        instance_count = 1
        app_port = 8080
        app_subnet_name = "app_subnet"
        lb_subnet_name = "app_subnet"
        alb_name = "private"
        priority = 4
    }
      payment = {
        instance_type = "t3.small"
        instance_count = 1
        app_port = 8080
        app_subnet_name = "app_subnet"
        lb_subnet_name = "app_subnet"
        alb_name = "private"
        priority = 5
    }
      dispatch = {
        instance_type = "t3.small"
        instance_count = 1
        app_port = 8080
        app_subnet_name = "app_subnet"
        lb_subnet_name = "app_subnet"
        alb_name = "private"
        priority = 6
   }
}
 
alb = {
  public = {
    certificate_arn = "arn:aws:acm:us-east-1:751177946459:certificate/f004e848-d847-45e8-b070-c290fb1b072c"
    internal = false
    sg_cidrs = "internet"
    subnet_name = "public_subnet"

  }

  private = {
    certificate_arn = "arn:aws:acm:us-east-1:751177946459:certificate/f004e848-d847-45e8-b070-c290fb1b072c"
    internal = true
    sg_cidrs = "app_subnet"
    subnet_name = "public_subnet"

  }
}

