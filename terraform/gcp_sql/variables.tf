variable "project" {
  type = string
}
variable "region" {
  type = string
}
variable "database_config" {
  type = object({
    instance = object({
      name          = string
      version       = string
      database_tier = string
    })
    db_user = string
    db_name = string
  })
}

