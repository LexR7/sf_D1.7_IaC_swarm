terraform {
  required_version = ">= 1.0.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.69.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = file("/Users/r_alexey/EduProjects/terra-service.json")
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
}

#module "vpc" {
#  source = "./modules/yandex-vpc"
#
#  name    = var.name
#  subnets = var.subnets
#}


module "vm-1" {
  source = "./modules/yandex-instance"

  vm_name     = "${var.name}-${var.vm_params[0].name}"
  vm_hostname = var.vm_params[0].name
  #  vm_zone       = module.vpc.subnet_zones[0]
  vm_zone     = var.subnets[0].zone
  family      = var.vm_params[0].family
  platform_id = var.vm_params[0].platform_id
  nat         = var.vm_params[0].nat
  #  vpc_subnet_id = module.vpc.subnet_ids[0]
  vpc_subnet_id = var.subnets[0].subnet_id
  users         = file("/Users/r_alexey/EduProjects/user_ansible.txt")
  resources     = var.vm_params[0].resources
}


module "vm-2" {
  source = "./modules/yandex-instance"

  vm_name     = "${var.name}-${var.vm_params[1].name}"
  vm_hostname = var.vm_params[1].name
  #  vm_zone       = module.vpc.subnet_zones[0]
  vm_zone     = var.subnets[0].zone
  family      = var.vm_params[1].family
  platform_id = var.vm_params[1].platform_id
  nat         = var.vm_params[1].nat
  #  vpc_subnet_id = module.vpc.subnet_ids[0]
  vpc_subnet_id = var.subnets[0].subnet_id
  users         = file("/Users/r_alexey/EduProjects/user_ansible.txt")
  resources     = var.vm_params[1].resources
}

module "vm-3" {
  source = "./modules/yandex-instance"

  vm_name     = "${var.name}-${var.vm_params[2].name}"
  vm_hostname = var.vm_params[2].name
  #  vm_zone       = module.vpc.subnet_zones[0]
  vm_zone     = var.subnets[0].zone
  family      = var.vm_params[2].family
  platform_id = var.vm_params[2].platform_id
  nat         = var.vm_params[2].nat
  #  vpc_subnet_id = module.vpc.subnet_ids[0]
  vpc_subnet_id = var.subnets[0].subnet_id
  users         = file("/Users/r_alexey/EduProjects/user_ansible.txt")
  resources     = var.vm_params[2].resources
}

#Создать инвентори файл для ансибл
resource "local_file" "inventory" {
  filename        = "./ansible-docker/inventory/hosts.yml"
  file_permission = "0644"
  content         = <<-EOT
[manager]
manager-1 ansible_host=${module.vm-1.external_ip_address} internal_ip=${module.vm-1.internal_ip_address}
[worker]
worker-1 ansible_host=${module.vm-2.external_ip_address} internal_ip=${module.vm-2.internal_ip_address}
worker-2 ansible_host=${module.vm-3.external_ip_address} internal_ip=${module.vm-3.internal_ip_address}
EOT
}

module "rexec-check-vm1" {
  source = "./modules/rexec"
  exec_params = {
    user        = "ansible",
    private_key = "/Users/r_alexey/.ssh/id_ed25519",
    ip_address  = module.vm-1.external_ip_address,
    command     = ["echo 'vm-1 is up'"]
  }
}

module "rexec-check-vm2" {
  source = "./modules/rexec"
  exec_params = {
    user        = "ansible",
    private_key = "/Users/r_alexey/.ssh/id_ed25519",
    ip_address  = module.vm-2.external_ip_address,
    command     = ["echo 'vm-2 is up'"]
  }
}

module "rexec-check-vm3" {
  source = "./modules/rexec"
  exec_params = {
    user        = "ansible",
    private_key = "/Users/r_alexey/.ssh/id_ed25519",
    ip_address  = module.vm-3.external_ip_address,
    command     = ["echo 'vm-3 is up'"]
  }
}

#Копируем на управляющий сервер docker compose файл
resource "null_resource" "copy-stack" {
  connection {
    type        = "ssh"
    user        = "ansible"
    certificate = file("/Users/r_alexey/.ssh/id_ed25519")
    host        = module.vm-1.external_ip_address
  }

  provisioner "file" {
    source      = "./docker_swarm"
    destination = "/home/ansible/"
  }
}

resource "null_resource" "run-ansible" {
  depends_on = [module.rexec-check-vm1, module.rexec-check-vm2, module.rexec-check-vm3, null_resource.copy-stack]
  provisioner "local-exec" {
    command = "cd ./ansible-docker && ansible-playbook deploy_docker.yml -i inventory && ansible-playbook deploy_swarm.yml -i inventory"
  }
}