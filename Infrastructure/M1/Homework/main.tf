terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "bgapp-db" {
  name = "shekeriev/bgapp-db:latest"
}

resource "docker_image" "bgapp-web" {
  name = "shekeriev/bgapp-web:latest"
}

resource "docker_network" "private_network" {
  name = "app-net"
}

resource "docker_container" "web" {
  name  = "site"
  image = docker_image.bgapp-web.image_id
  ports {
    internal = "80"
    external = "8000"
  }
  networks_advanced {
    name = "app-net"
  }
  volumes {
    host_path = "/home/vagrant/bgapp/web"
    container_path = "/var/www/html"
  }
}

resource "docker_container" "db" {
  name  = "db"
  image = docker_image.bgapp-db.image_id
  env = [
    "MYSQL_ROOT_PASSWORD=12345",
  ]
  networks_advanced {
    name = "app-net"
  }
}

provider "docker" {
  host = "tcp://192.168.99.100:2375/"
}