build {
  sources = [join(".", ["source", var.plugin, "template"])]

  provisioner "shell" {
    inline = var.commands_provision
    expect_disconnect = true
    except = var.is_windows ? join(".", ["source", var.plugin, "template"]) : null
  }

  provisioner "powershell" {
    elevated_password = ""
    elevated_user = ""
    scripts = ""
    except = var.is_windows ? null : join(".", ["source", var.plugin, "template"])
  }

  provisioner "windows-restart" {}
  provisioner "windows-update" {}
}