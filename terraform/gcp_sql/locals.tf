locals {
  database_config = merge({
    instance = {
      name          = "my-database-instance"
      version       = "POSTGRES_15"
      database_tier = "db-f1-micro"
    }
    db_user = "root"
    db_name = "mydatabase"
  }, var.database_config)
}


