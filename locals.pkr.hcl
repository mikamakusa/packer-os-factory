locals {
  templates = join("/", [path.root, "templates", join(".", ["source", var.plugin, "pkr.hcl"])])
  vm_name                    = join("-", [var.vm_guest_os_family, var.vm_guest_os_name, var.vm_guest_os_version, var.vm_suffix])
  iso_paths       = join("/", [var.iso_path, var.iso_file])
  iso_checksum    = "${var.iso_checksum_type}:${var.iso_checksum_value}"
  manifest_date   = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
  manifest_path   = join("/", [path.cwd, "manifests"])
  manifest_output = join(".", [local.manifest_path, local.manifest_date])
}