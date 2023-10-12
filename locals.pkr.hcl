locals {
  iso_paths = var.plugin == "vsphere" ? (
    var.is_windows ? [
      "[DATA_DS1] ${var.iso_path}/${var.iso_file}",
      "[DATA_DS1] ISOS/VMware-Tools/${var.iso_tools}"
      ] : [
      "[DATA_DS1] ${var.iso_path}/${var.iso_file}",
  ]) : ""
  templates       = join("/", [path.root, "templates", join(".", ["source", var.plugin, "pkr.hcl"])])
  vm_name         = join("-", [var.vm_guest_os_family, var.vm_guest_os_name, var.vm_guest_os_version, var.vm_suffix])
  iso_checksum    = "none"
  manifest_date   = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
  manifest_path   = join("/", [path.cwd, "manifests"])
  manifest_output = join(".", [local.manifest_path, local.manifest_date])
  cd_files = var.is_windows ? [
    "${path.root}/scripts/windows/provision-winrm.ps1"
    ] : [
    "${path.root}/scripts/linux/*.sh"
  ]
  data_source_content = var.is_windows ? {
    "/autounattend.xml" = "${abspath(path.root)}/datas/Autounattend.xml"
    } : {
    "/kickstart.cfg" = templatefile("${abspath(path.root)}/datas/kickstart.cfg", {})
  }
}