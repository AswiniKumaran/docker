terraform{
  backend "s3" {
    bucket = "learn-docker-3"
    key="terraform/terraform.tfstate"
    region = "eu-north-1"
  }
  required_providers {
    render = {
      source = "render-oss/render"
      version = "1.8.0"
    }
  }
}

variable "RENDER_API_KEY" {}
variable "RENDER_OWNER_ID" {}
variable "GHCR_USER_NAME" {}
variable "GHCR_AUTH_TOKEN" {}
variable "POSTGRES_DB" {}
variable "POSTGRES_USER" {}
variable "SECRET_KEY" {}

provider "render" {
  api_key = var.RENDER_API_KEY
  owner_id = var.RENDER_OWNER_ID
}

resource "render_registry_credential" "ghcr_credential" {
  name       = "ghcr_credential"
  registry   = "GITHUB"
  username   = var.GHCR_USER_NAME
  auth_token = var.GHCR_AUTH_TOKEN
}

resource "render_postgres" "prod_postgres" {
  name    = "prod_postgres"
  plan    = "free"
  region  = "frankfurt"
  version = "17"

  database_name = var.POSTGRES_DB
  database_user = var.POSTGRES_USER

  high_availability_enabled = false
}

resource "render_web_service" "my_django_app" {
  name    = "my_django_app"
  plan    = "starter"
  region  = "frankfurt"

  runtime_source = {
    image = {
      image_url = "ghcr.io/aswinikumaran/first_docker_app"
      registry_credential_id=render_registry_credential.ghcr_credential.id
      tag="latest"
    }
  }

  env_vars = {
    "SECRET_KEY" = {value = var.SECRET_KEY}
  }
}