resource "random_string" "postgres_password" {
  length  = 24
  upper   = true
  lower   = true
  numeric = true
  special = false
}

resource "google_sql_database_instance" "instance" {
  name             = local.database_config.instance.name
  database_version = local.database_config.instance.version
  region           = var.region
  settings {
    tier = local.database_config.instance.database_tier
  }
}

resource "google_sql_database" "database" {
  name      = local.database_config.db_name
  instance  = google_sql_database_instance.instance.name
  charset   = "utf8"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "users" {
  name     = local.database_config.db_user
  instance = google_sql_database_instance.instance.name
  host     = "%"
  password = random_string.postgres_password.result
}
