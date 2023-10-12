source "vsphere-iso" "template" {
  vcenter_server       = var.vm_vsphere_endpoint
  host                 = var.vm_vsphere_host
  resource_pool        = var.vm_vsphere_resource_pool
  username             = var.vm_vsphere_username
  password             = var.vm_vsphere_password
  insecure_connection  = var.vm_vsphere_insecure_connection
  datacenter           = var.vm_vsphere_datacenter
  cluster              = var.vm_vsphere_cluster
  datastore            = var.vm_vsphere_datastore
  folder               = var.vm_vsphere_folder
  vm_name              = local.vm_name
  guest_os_type        = var.vm_guest_os_type
  firmware             = var.vm_firmware
  CPUs                 = var.vm_cpu_count
  cpu_cores            = var.vm_cpu_cores
  CPU_hot_plug         = var.vm_cpu_hot_add
  RAM                  = var.vm_mem_size
  RAM_hot_plug         = var.vm_mem_hot_add
  cdrom_type           = var.vm_cdrom_type
  disk_controller_type = ["lsilogic-sas"]
  vm_version           = var.common_vm_version
  remove_cdrom         = var.common_remove_cdrom
  tools_upgrade_policy = var.common_tools_upgrade_policy
  iso_paths            = local.iso_paths
  iso_checksum         = local.iso_checksum
  cd_files = var.is_windows ? [
    join("/", [path.root, "datas", "autounattend.xml"]),
    ] : [
    join("/", [path.root, "datas", "kickstart.cfg"])
  ]
  floppy_files = var.is_windows ? [
    join("/", [path.root, "scripts", "windows", "initial-setup.ps1"])
  ] : null
  boot_order          = var.vm_boot_order
  boot_wait           = var.vm_boot_wait
  ip_wait_timeout     = var.common_ip_wait_timeout
  shutdown_command    = var.is_windows == true ? "shutdown -s -t 0 -f" : "echo 'Packer Shutdown' | sudo -S /sbin/halt -h -p"
  shutdown_timeout    = var.common_shutdown_timeout
  communicator        = var.vm_communicator != "none" ? (var.is_windows ? "winrm" : "ssh") : var.vm_communicator
  ssh_proxy_host      = var.is_windows ? null : var.communicator_proxy_host
  ssh_proxy_port      = var.is_windows ? null : var.communicator_proxy_port
  ssh_proxy_username  = var.is_windows ? null : var.communicator_proxy_username
  ssh_proxy_password  = var.is_windows ? null : var.communicator_proxy_password
  ssh_username        = var.is_windows ? null : var.build_username
  ssh_password        = var.is_windows ? null : var.build_password
  ssh_port            = var.is_windows ? null : var.communicator_port
  ssh_timeout         = var.is_windows ? null : var.communicator_timeout
  winrm_username      = var.is_windows ? var.communicator_winrm_username : null
  winrm_password      = var.is_windows ? var.communicator_winrm_password : null
  winrm_host          = var.is_windows ? var.communicator_winrm_host : null
  winrm_no_proxy      = var.is_windows ? var.communicator_winrm_no_proxy : null
  winrm_port          = var.is_windows ? var.communicator_winrm_port : null
  winrm_timeout       = var.is_windows ? var.communicator_winrm_timeout : null
  winrm_use_ssl       = var.is_windows ? var.communicator_winrm_use_ssl : null
  winrm_insecure      = var.is_windows ? var.communicator_winrm_insecure : null
  winrm_use_ntlm      = var.is_windows ? var.communicator_winrm_use_ntlm : null
  convert_to_template = var.common_template_conversion

  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = var.vm_disk_thin_provisioned
  }

  network_adapters {
    network      = var.vm_vsphere_network
    network_card = var.vm_network_card
  }

  boot_command = var.is_windows ? ["<spacebar>"] : [
    "<up>",
    "e",
    "<down><down><end><wait>",
    "text ${local.data_source_command}",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]

  dynamic "content_library_destination" {
    for_each = var.common_content_name != null ? [1] : []
    content {
      library = var.common_content_library
      name    = var.common_content_name
      ovf     = var.common_content_ovf
    }
  }

  dynamic "export" {
    for_each = var.common_ovf_export_enabled == true ? [1] : []
    content {
      name  = local.vm_name
      force = var.common_ovf_export_overwrite
      options = [
        "extraconfig"
      ]
      output_directory = local.ovf_export_path
    }
  }
}

source "virtualbox-iso" "template" {
  vm_name                   = local.vm_name
  guest_os_type             = var.vm_guest_os_type
  iso_url                   = local.iso_paths
  iso_checksum              = local.iso_checksum
  ssh_username              = var.vm_ssh_username
  ssh_password              = var.vm_ssh_password
  shutdown_command          = "echo '${local.vm_name}' | sudo -S -E shutdown -P now"
  chipset                   = var.vm_chipset
  firmware                  = var.vm_firmware
  nested_virt               = var.vm_nested_virt
  rtc_time_base             = var.vm_rtc_time_base
  disk_size                 = var.vm_disk_size
  audio_controller          = var.vm_audio_controller
  gfx_controller            = var.vm_gfx_controller
  gfx_vram_size             = var.vm_gfx_vram_size
  gfx_accelerate_3d         = var.vm_gfx_accelerate_3d
  gfx_efi_resolution        = var.vm_gfx_efi_resolution
  hard_drive_discard        = var.vm_hard_drive_discard
  hard_drive_interface      = var.vm_hard_drive_interface
  sata_port_count           = var.vm_sata_port_count
  nvme_port_count           = var.vm_nvme_port_count
  hard_drive_nonrotational  = var.vm_hard_drive_nonrotational
  iso_interface             = var.vm_iso_interface
  disk_additional_size      = var.vm_disk_additional_size
  keep_registered           = var.vm_keep_registered
  skip_export               = var.vm_skip_export
  virtualbox_version_file   = join("-", ["packer", local.vm_name])
  bundle_iso                = var.vm_bundle_iso
  guest_additions_mode      = var.vm_guest_additions_mode
  guest_additions_interface = var.vm_guest_additions_interface
  guest_additions_path      = var.vm_guest_additions_path
  guest_additions_sha256    = var.vm_guest_additions_sha256
  guest_additions_url       = var.vm_guest_additions_url
  http_directory            = var.vm_http_directory
  http_content              = var.common_data_source == "http" ? local.data_source_content : null
  http_port_min             = var.common_data_source == "http" ? var.vm_http_port_min : null
  http_port_max             = var.common_data_source == "http" ? var.vm_http_port_max : null
  http_bind_address         = var.common_data_source == "http" ? var.vm_http_bind_address : null
  floppy_files              = var.vm_floppy_files
  floppy_dirs               = var.vm_floppy_dirs
  floppy_content            = var.vm_floppy_content
  floppy_label              = var.vm_floppy_label
  cd_files                  = var.vm_cd_files
  cd_label                  = var.vm_cd_label
  cd_content                = var.common_data_source == "disk" ? local.data_source_content : null
  format                    = var.vm_format
  export_opts               = var.vm_export_opts
  output_directory          = join("-", ["output", local.vm_name])
  output_filename           = local.vm_name
  headless                  = var.vm_headless
  vrdp_bind_address         = var.vm_vrdp_bind_address
  vrdp_port_min             = var.vm_vrdp_port_min
  vrdp_port_max             = var.vm_vrdp_port_max
  shutdown_timeout          = var.vm_shutdown_timeout
  post_shutdown_delay       = var.vm_post_shutdown_delay
  disable_shutdown          = var.vm_disable_shutdown
  acpi_shutdown             = var.vm_acpi_shutdown
  cpus                      = var.vm_cpus
  memory                    = var.vm_memory
  sound                     = var.vm_sound
  usb                       = var.vm_usb
  vboxmanage                = var.vm_vboxmanage
  vboxmanage_post           = var.vm_vboxmanage_post
  ssh_timeout               = "30m"
  boot_command = var.is_windows ? ["<spacebar>"] : [
    "<up>",
    "e",
    "<down><down><end><wait>",
    "text ${local.data_source_command}",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]
}

source "digitalocean" "template" {
  api_token               = var.api_token
  region                  = var.region
  size                    = var.size
  image                   = var.image
  api_url                 = var.api_url
  private_networking      = var.private_networking
  monitoring              = var.monitoring
  droplet_agent           = var.droplet_agent
  droplet_name            = local.vm_name
  ipv6                    = var.ipv6
  snapshot_name           = var.snapshot_name
  snapshot_regions        = var.snapshot_regions
  state_timeout           = var.state_timeout
  user_data               = var.user_data
  tags                    = var.tags
  vpc_uuid                = var.vpc_uuid
  connect_with_private_ip = var.connect_with_private_ip
  ssh_key_id              = var.ssh_key_id
  ssh_private_key_file    = var.ssh_private_key_file
}

source "azure-arm" "template" {
  client_id                         = var.client_id
  client_secret                     = var.client_secret
  storage_account                   = var.storage_account
  subscription_id                   = var.subscription_id
  tenant_id                         = var.tenant_id
  managed_image_resource_group_name = var.managed_image_resource_group_name
  user_assigned_managed_identities  = join("-", ["squad", var.os_type, var.image_sku, var.service])
  os_type                           = var.os_type
  image_publisher                   = var.image_publisher
  image_offer                       = var.image_offer
  image_sku                         = var.image_sku
  secure_boot_enabled               = true
  vtpm_enabled                      = true
  communicator                      = var.is_windows ? "winrm" : "ssh"
  ssh_proxy_host                    = var.is_windows ? null : var.communicator_proxy_host
  ssh_proxy_port                    = var.is_windows ? null : var.communicator_proxy_port
  ssh_proxy_username                = var.is_windows ? null : var.communicator_proxy_username
  ssh_proxy_password                = var.is_windows ? null : var.communicator_proxy_password
  ssh_username                      = var.is_windows ? null : var.build_username
  ssh_password                      = var.is_windows ? null : var.build_password
  ssh_port                          = var.is_windows ? null : var.communicator_port
  ssh_timeout                       = var.is_windows ? null : var.communicator_timeout
  winrm_username                    = var.is_windows ? var.communicator_winrm_username : null
  winrm_password                    = var.is_windows ? var.communicator_winrm_password : null
  winrm_host                        = var.is_windows ? var.communicator_winrm_host : null
  winrm_no_proxy                    = var.is_windows ? var.communicator_winrm_no_proxy : null
  winrm_port                        = var.is_windows ? var.communicator_winrm_port : null
  winrm_timeout                     = var.is_windows ? var.communicator_winrm_timeout : null
  winrm_use_ssl                     = var.is_windows ? var.communicator_winrm_use_ssl : null
  winrm_insecure                    = var.is_windows ? var.communicator_winrm_insecure : null
  winrm_use_ntlm                    = var.is_windows ? var.communicator_winrm_use_ntlm : null
  azure_tags                        = var.azure_tags
}
