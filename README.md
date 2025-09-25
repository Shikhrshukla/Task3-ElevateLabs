# Infrastructure as Code (IaC) with Terraform (ElevateLabs : Task 3)
This repository contains the solution for Task 3 of the DevOps Internship. The objective is to use Terraform to provision and manage a local Docker container, demonstrating a fundamental understanding of Infrastructure as Code (IaC) principles.

---

## File Structure

```
➜ tree
.
├── main.tf
├── README.md
├── sample_logs.txt
├── terraform.tfstate
└── terraform.tfstate.backup

1 directory, 5 files
```

## 1. Task Objective
The primary goal of this task is to provision a local Docker container running the image using Terraform. This involves writing an IaC configuration, managing its lifecycle (create, update, destroy), and understanding the core concepts of Terraform.

---

## 2. Tools Used
- **Terraform:** An open-source Infrastructure as Code tool by HashiCorp.
- **Docker:** A platform for developing, shipping, and running applications in containers.

---

## 3. Project Files
- **main.tf:** The main Terraform configuration file containing the code to define and provision the Docker resources.
- **README.md:** This documentation file.

---

## 4. Execution Steps & Logs
**Prerequisites**
- Terraform CLI installed.
- Docker Desktop running locally.

### Step 1: Initialize Terraform (terraform init)
This command initializes the working directory, downloads the required Docker provider plugin, and sets up the backend for state management.
**Execution Log:**
```bash
➜ terraform init

Initializing the backend...
Initializing provider plugins...
- Reusing previous version of kreuzwerker/docker from the dependency lock file
- Using previously-installed kreuzwerker/docker v3.6.2

Terraform has been successfully initialized!
```

### Step 2: Create an Execution Plan (terraform plan)
This command creates an execution plan, which is a dry run. It shows what actions Terraform will take (create, change, or destroy) without actually performing them. This is a critical step for validation.
**Execution Log:**
```bash
➜ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.mydesktop will be created
  + resource "docker_container" "mydesktop" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "terraform-ubuntu"
      + network_data                                = (known after apply)
      + network_mode                                = "bridge"
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "on-failure"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = true
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck (known after apply)

      + labels (known after apply)

      + ports {
          + external = 8080
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }
```

### Step 3: Apply the Configuration (terraform apply)
This command applies the changes defined in the execution plan, provisioning the actual infrastructure. It will pull the Docker image and create the container.

**Execution Log:**
```bash
➜ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.mydesktop will be created
  + resource "docker_container" "mydesktop" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = (known after apply)
      + init                                        = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "terraform-ubuntu"
      + network_data                                = (known after apply)
      + network_mode                                = "bridge"
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "on-failure"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = true
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck (known after apply)

      + labels (known after apply)

      + ports {
          + external = 8080
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # docker_image.ubuntu will be created
  + resource "docker_image" "ubuntu" {
      + id           = (known after apply)
      + image_id     = (known after apply)
      + keep_locally = false
      + name         = "ubuntu:latest"
      + repo_digest  = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```

### Step 4: Verify the Container
After a successful apply, I verified that the container was running using the standard Docker command.

**Execution Log:**
```bash
➜ docker ps | grep terraform

88606408228f      6d79abd4c962      "/bin/bash"      3 minutes ago      Up 3 minutes      0.0.0.0:8080->80/tcp      terraform-ubuntu
```

### Step 5: Inspect the State (terraform state)
The terraform state command is used to interact with the state file. I used it to list the resources that Terraform is managing.

**Execution Log:**
```bash
➜ terraform state list

docker_container.mydesktop
docker_image.ubuntu
```

### Step 6: Destroy the Infrastructure (terraform destroy)
This command tears down all the resources managed by the configuration, removing the container and the image as defined.

**Execution Log:**
```bash
➜ terraform destroy -auto-approve

docker_image.ubuntu: Refreshing state... [id=sha256:6d79abd4c96299aa91f5a4a46551042407568a3858b00ab460f4ba430984f62cubuntu:latest]
docker_container.mydesktop: Refreshing state... [id=88606408228fd443dd8a8e6dea6918bcb6e0da742e178945b6317a0f7360f1b8]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # docker_container.mydesktop will be destroyed
  - resource "docker_container" "mydesktop" {
      - attach                                      = false -> null
      - command                                     = [
          - "/bin/bash",
        ] -> null
      - container_read_refresh_timeout_milliseconds = 15000 -> null
      - cpu_shares                                  = 0 -> null
      - dns                                         = [] -> null
      - dns_opts                                    = [] -> null
      - dns_search                                  = [] -> null
      - entrypoint                                  = [] -> null
      - env                                         = [] -> null
      - group_add                                   = [] -> null
      - hostname                                    = "88606408228f" -> null
      - id                                          = "88606408228fd443dd8a8e6dea6918bcb6e0da742e178945b6317a0f7360f1b8" -> null
      - image                                       = "sha256:6d79abd4c96299aa91f5a4a46551042407568a3858b00ab460f4ba430984f62c" -> null
      - init                                        = false -> null
      - ipc_mode                                    = "private" -> null
      - log_driver                                  = "json-file" -> null
      - log_opts                                    = {} -> null
      - logs                                        = false -> null
      - max_retry_count                             = 0 -> null
      - memory                                      = 0 -> null
      - memory_swap                                 = 0 -> null
      - must_run                                    = true -> null
      - name                                        = "terraform-ubuntu" -> null
      - network_data                                = [
          - {
              - gateway                   = "172.17.0.1"
              - global_ipv6_prefix_length = 0
              - ip_address                = "172.17.0.2"
              - ip_prefix_length          = 16
              - mac_address               = "ee:06:30:86:0b:0d"
              - network_name              = "bridge"
                # (2 unchanged attributes hidden)
            },
        ] -> null
```

---

## 5. Terraform Code (main.tf)
```hcl
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
```

---

## 6. Screenshots

<img width="1920" height="1080" alt="1" src="https://github.com/user-attachments/assets/c287df65-c2f1-4d41-b8a4-dbe024832ca7" />

<img width="1920" height="1080" alt="2" src="https://github.com/user-attachments/assets/e6df2f5a-1f9c-4fba-93ee-22895bfb50b9" />

<img width="1920" height="1080" alt="3" src="https://github.com/user-attachments/assets/6b7118eb-e420-408d-8bbc-6c7e74e36a79" />

<img width="1920" height="1080" alt="4" src="https://github.com/user-attachments/assets/750cb651-97a1-41c5-9bee-85bca501e17c" />

<img width="1920" height="1080" alt="5" src="https://github.com/user-attachments/assets/82d6e94c-13c9-487c-8f3c-e71fde8e3007" />

<img width="1920" height="1080" alt="6" src="https://github.com/user-attachments/assets/5723319e-377a-4f38-bbc6-b1afffd7037c" />

---
