terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker" // official docker provider
      version = "3.6.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"    // default docker host

}

# Pulls the image
resource "docker_image" "ubuntu" {
  name = "ubuntu:latest"          
  keep_locally = false            // remove the image after container is removed
}

# Create a container
resource "docker_container" "mydesktop" {
  name  = "terraform-ubuntu"
  image = docker_image.ubuntu.image_id
  ports {
    internal = 80    //container port
    external = 8080  //host port
  }
  restart = "on-failure" // restart policy
  tty     = true        // allocate a pseudo-TTY to run an interactive bash shell
}

output "container_id" {
  value = docker_container.mydesktop.id
}
output "container_logs" {
  value = docker_container.mydesktop.logs
}
output "container_name" {
  value = docker_container.mydesktop.name
}