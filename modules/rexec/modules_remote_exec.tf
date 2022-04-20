resource "null_resource" "remote-exec" {
  connection {
    type        = "ssh"
    user        = var.exec_params.user
    certificate = file(var.exec_params.private_key)
    host        = var.exec_params.ip_address
  }

  provisioner "remote-exec" {
    inline = var.exec_params.command
  }
}

