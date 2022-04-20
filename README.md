Практическое задание D1.7
Все действия выполняются запуском terraform apply
В ходе которого с использованием ansible выполняется установка и последующая настройка<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.1.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | 0.69.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_rexec-check-vm1"></a> [rexec-check-vm1](#module\_rexec-check-vm1) | ./modules/rexec | n/a |
| <a name="module_rexec-check-vm2"></a> [rexec-check-vm2](#module\_rexec-check-vm2) | ./modules/rexec | n/a |
| <a name="module_rexec-check-vm3"></a> [rexec-check-vm3](#module\_rexec-check-vm3) | ./modules/rexec | n/a |
| <a name="module_vm-1"></a> [vm-1](#module\_vm-1) | ./modules/yandex-instance | n/a |
| <a name="module_vm-2"></a> [vm-2](#module\_vm-2) | ./modules/yandex-instance | n/a |
| <a name="module_vm-3"></a> [vm-3](#module\_vm-3) | ./modules/yandex-instance | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.inventory](https://registry.terraform.io/providers/hashicorp/local/2.1.0/docs/resources/file) | resource |
| [null_resource.copy-stack](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.run-ansible](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | Идентификатор облака | `string` | n/a | yes |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Идентификатор каталога | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Наименование создаваемых ресурсов | `string` | `"terra"` | no |
| <a name="input_region"></a> [region](#input\_region) | Регион | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Данные подсетей (зона, адрес) | <pre>list(object({<br>    subnet_id      = string<br>    zone           = string<br>    v4_cidr_blocks = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "subnet_id": "",<br>    "v4_cidr_blocks": [<br>      "10.0.0.0/24"<br>    ],<br>    "zone": "ru-central1-a"<br>  },<br>  {<br>    "subnet_id": "",<br>    "v4_cidr_blocks": [<br>      "10.0.1.0/24"<br>    ],<br>    "zone": "ru-central1-b"<br>  }<br>]</pre> | no |
| <a name="input_vm_params"></a> [vm\_params](#input\_vm\_params) | Параметры создаваемых серверов | <pre>list(object({<br>    name        = string<br>    family      = string<br>    platform_id = string<br>    nat         = bool<br>    resources   = object({ cores = number, core_fraction = number, memory = number, disk_size = number, boot_disk_type = string })<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address_vm_1"></a> [external\_ip\_address\_vm\_1](#output\_external\_ip\_address\_vm\_1) | Назначенный внешний IP-адрес |
| <a name="output_internal_ip_address_vm_1"></a> [internal\_ip\_address\_vm\_1](#output\_internal\_ip\_address\_vm\_1) | Назначенный внутренний IP-адрес |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
