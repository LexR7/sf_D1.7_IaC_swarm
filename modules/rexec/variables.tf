variable "exec_params" {
  description = "Параметры (пользователь, путь к файлу с закрытым ключом, ip адрес и команда для выполнения)"
  type = object({
    user        = string
    private_key = string
    ip_address  = string
    command     = list(string)
  })
}
