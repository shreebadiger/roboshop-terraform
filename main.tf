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

