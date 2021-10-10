resource "aws_db_instance" "db" {
    allocated_storage                     = 250
    auto_minor_version_upgrade            = false
    availability_zone                     = "ap-southeast-1b"
    # backup_retention_period               = 0
    # backup_window                         = "16:34-17:04"
    # ca_cert_identifier                    = "rds-ca-2019"
    character_set_name                    = "SQL_Latin1_General_CP1_CI_AS"
    copy_tags_to_snapshot                 = true
    customer_owned_ip_enabled             = false
    db_subnet_group_name                  = "default-vpc-0321a564ad761c349"
    delete_automated_backups              = true
    deletion_protection                   = false
    enabled_cloudwatch_logs_exports       = []
    engine                                = "sqlserver-se"
    # engine_version                        = "13.00.5882.1.v1"
    # engine_version_actual                 = "13.00.5882.1.v1"
    # hosted_zone_id                        = "Z2G0U3KFCY8NZ5"
    iam_database_authentication_enabled   = false
    # id                                    = "pmp-downloader-db-standard"
    identifier                            = "pmp-downloader-db-standard"
    instance_class                        = "db.m5.large"
    iops                                  = 3000
    # latest_restorable_time                = "0001-01-01T00:00:00Z"
    license_model                         = "license-included"
    # maintenance_window                    = "wed:18:01-wed:18:31"
    max_allocated_storage                 = 0
    monitoring_interval                   = 0
    multi_az                              = false
    # option_group_name                     = "default:sqlserver-se-13-00"
    # parameter_group_name                  = "default.sqlserver-se-13.0"
    performance_insights_enabled          = false
    performance_insights_retention_period = 0
    port                                  = 1433
    publicly_accessible                   = false
    # replicas                              = []
    # resource_id                           = "db-JHEDFV4IDVRW2WCCQLSKSLSB34"
    security_group_names                  = []
    skip_final_snapshot                   = true
    storage_encrypted                     = false
    storage_type                          = "io1"
    tags                                  = {
        "Application" = "PMP"
        "Module"      = "APPDB"
        "Name"        = "AW-SE1PWAPPDB01"
        "Owner"       = "Myo"
        "Stack"       = "Prod"
        "Type"        = "Database"
    }
    password                              = "foobarbaz"
    username                              = "myo_kyaw"
    vpc_security_group_ids                = [aws_security_group.db.id]
}



resource "aws_security_group" "db" {
    name        = "PMP-Downlaod-Database-SG"
    description = "Created by RDS management console"
    vpc_id      = "vpc-0321a564ad761c349"
    egress      = [{
            cidr_blocks      = ["0.0.0.0/0"]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        }]
    ingress     = [{
            cidr_blocks      = []
            description      = ""
            from_port        = 1433
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = [module.two.aws_security_group]
            self             = false
            to_port          = 1433
        },
        {
            cidr_blocks      = []
            description      = "Allow MySQL port from Downloader"
            from_port        = 1433
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = [module.three.aws_security_group]
            self             = false
            to_port          = 1433
        }]
    tags        = {
        "Application" = "PMP"
        "Module"      = "APPDB"
        "Name"        = "PMP-APPDB-SG"
        "Owner"       = "Myo"
        "Stack"       = "Prod"
        "Type"        = "Database"
    }
}
