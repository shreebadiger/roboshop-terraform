module "vpc" {
    source = "git::https://github.com/shreebadiger/tf-module-vpc.git"

    for_each = var.vpc
    vpc_cidr_block = each.value["vpc_cidr_block"]
    public_subnet = each.value["public_subnet"]
    web_subnet = each.value["web_subnet"]
    app_subnet = each.value["app_subnet"]
    db_subnet = each.value["db_subnet"]
    azs_subnet = each.value["azs_subnet"]

    env = var.env
    tags = var.tags
    default_vpc_cidr = var.default_vpc_cidr
    default_vpc_id = var.default_vpc_id
    default_route_table_id = var.default_route_table_id
    account_id = var.account_id
}

module "rds" {
    source = "git::https://github.com/shreebadiger/tf-module-rds.git"

    for_each = var.rds
    allocated_storage =  each.value["allocated_storage"]
    engine = each.value["engine"]
    engine_version = each.value["engine_version"]
    instance_class = each.value["instance_class"]
    parameter_group_family = each.value["parameter_group_family"]

    env = var.env
    tags = var.tags
    kms = var.kms

    subnets = lookup(lookup(module.vpc,"main",null), "db_subnet",null)
    vpc_id = lookup(lookup(module.vpc,"main",null),"vpc_id",null)
    sg_cidrs = lookup(lookup(var.vpc,"main",null),"app_subnet",null)
    
}


module "docdb" {
    source = "git::https://github.com/shreebadiger/tf-module-docdb.git"

    for_each = var.docdb
    engine = each.value["engine"]
    engine_version = each.value["engine_version"]
    instance_class = each.value["instance_class"]
    parameter_group_family = each.value["parameter_group_family"]
    instance_count = each.value["instance_count"]

    env = var.env
    tags = var.tags
    kms = var.kms

    subnets = lookup(lookup(module.vpc,"main",null), "db_subnet",null)
    vpc_id = lookup(lookup(module.vpc,"main",null),"vpc_id",null)
    sg_cidrs = lookup(lookup(var.vpc,"main",null),"app_subnet",null)
    
}

module "elasticache" {
    source = "git::https://github.com/shreebadiger/tf-module-elasticache.git"

    for_each = var.elasticache
    engine = each.value["engine"]
    engine_version = each.value["engine_version"]
    node_type = each.value["node_type"]
    parameter_group_family = each.value["parameter_group_family"]
    num_cache_nodes = each.value["num_cache_nodes"]

    env = var.env
    tags = var.tags
    kms = var.kms

    subnets = lookup(lookup(module.vpc,"main",null), "db_subnet",null)
    vpc_id = lookup(lookup(module.vpc,"main",null),"vpc_id",null)
    sg_cidrs = lookup(lookup(var.vpc,"main",null),"app_subnet",null)
    
}

module "rabbitmq" {
    source = "git::https://github.com/shreebadiger/tf-module-rabbitmq.git"

    for_each = var.rabbitmq
    instance_type = each.value["instance_type"]

    env = var.env
    tags = var.tags
    kms = var.kms

    subnets = lookup(lookup(module.vpc,"main",null), "db_subnet",null)
    vpc_id = lookup(lookup(module.vpc,"main",null),"vpc_id",null)
    sg_cidrs = lookup(lookup(var.vpc,"main",null),"app_subnet",null)
    bastion_cidrs = var.bastion_cidrs
    route53_zone_id = var.route53_zone_id
    
    
}


module "app" {
    source = "git::https://github.com/shreebadiger/tf-module-app.git"

    for_each = var.app
    component = each.key
    instance_type = each.value["instance_type"]
    instance_count = each.value["instance_count"]
    app_port = each.value["app_port"]
    priority = each.value["priority"]

    env = var.env
    tags = var.tags
    kms = var.kms

    subnets = lookup(lookup(module.vpc,"main",null), each.value["app_subnet_name"],null)
    vpc_id = lookup(lookup(module.vpc,"main",null),"vpc_id",null)
    sg_cidrs = lookup(lookup(var.vpc,"main",null),each.value["lb_subnet_name"],null)
    alb_name = lookup(lookup(module.alb,each.value["alb_name"],null),"alb_name",null)
    listener_arn = lookup(lookup(module.alb,each.value["alb_name"],null),"listener_arn",null)
    bastion_cidrs = var.bastion_cidrs
    prometheus_cidrs = var.prometheus_cidrs
    route53_zone_id = var.route53_zone_id

}

module "alb" {
    source = "git::https://github.com/shreebadiger/tf-module-alb.git"

    for_each = var.alb
    certificate_arn = each.value["certificate_arn"]
    internal = each.value["internal"]

    env = var.env
    tags = var.tags
    type = each.key
    route53_zone_id = var.route53_zone_id

    subnets = lookup(lookup(module.vpc,"main",null), each.value["subnet_name"],null)
    vpc_id = lookup(lookup(module.vpc,"main",null),"vpc_id",null)
    sg_cidrs = lookup(lookup(var.vpc,"main",null),each.value["sg_cidrs"],null)

}

