source "hyperv-iso" "template" {
  iso_checksum          = var.iso_checksum
  iso_url               = var.iso_url
  output_directory      = join("-", [local.output_directory, "hyperv"])
  disable_shutdown      = bool
  disk_size = number
  use_legacy_network_adapter = bool
  differencing_disk = bool
  use_fixed_vhd_format = bool
  disk_block_size = number
  memory = number
  secondary_iso_images = list(string)
  disk_additional_size = list(number)
  guest_additions_mode = string
  guest_additions_path = string
  vm_name = local.vm_name
  switch_name = string
  switch_vlan_id = string
  mac_address = string
  vlan_id = string
  cpus = number
  generation = number
  enable_mac_spoofing = bool
  enable_dynamic_memory = bool
  enable_secure_boot = bool
  secure_boot_template = string
  enable_virtualization_extensions = bool
  temp_path = string
  configuration_version = string
  keep_registered = bool
  skip_compaction = bool
  skip_export = bool
  headless = bool
  firs_boot_device = string
  boot_order = list(string)
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
  shutdown_command      = local.shutdown_command
  shutdown_timeout      = var.shutdown_timeout
  communicator = var.is_windows ? "winrm" : "ssh"
}

source "vsphere-iso" "template" {
  enable_dynamic_memory = local.hyperv_enable_dynamic_memory
  enable_secure_boot    = local.hyperv_enable_secure_boot
  generation            = var.hyperv_generation
  guest_additions_mode  = var.hyperv_guest_additions_mode
  switch_name           = var.hyperv_switch_name
  boot_command          = var.boot_command
  boot_wait             = local.boot_wait
  cpus                  = var.cpus
  communicator          = local.communicator
  disk_size             = var.disk_size
  floppy_files          = local.floppy_files
  headless              = var.headless
  http_directory        = local.http_directory
  iso_checksum          = var.iso_checksum
  iso_url               = var.iso_url
  memory                = local.memory
  output_directory      = join("-", [local.output_directory, "hyperv"])
  shutdown_command      = local.shutdown_command
  shutdown_timeout      = var.shutdown_timeout
  ssh_password          = var.ssh_password
  ssh_port              = var.ssh_port
  ssh_timeout           = var.ssh_timeout
  ssh_username          = var.ssh_username
  winrm_password        = var.winrm_password
  winrm_timeout         = var.winrm_timeout
  winrm_username        = var.winrm_username
  vm_name               = local.vm_name
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
  boot_command = [
    "<up>",
    "<tab>",
    "<wait>",
    "text ${local.data_source_command}",
    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]
}

source "parallels-iso" "template" {}

source "vagrant" "template" {}

source "qemu" "template" {}

source "vagrant" "template" {}

source "proxmox-iso" "template" {}

source "oracle-classic" "template" {}

source "openstack" "template" {}

source "nutanix" "template" {}

source "googlecompute" "template" {}

source "digitalocean" "template" {
  api_token = var.api_token
  region = var.region
  size = var.size
  image = var.image
  api_url = var.api_url
  private_networking = var.private_networking
  monitoring = var.monitoring
  droplet_agent = var.droplet_agent
  droplet_name = local.vm_name
  ipv6 = var.ipv6
  snapshot_name = var.snapshot_name
  snapshot_regions = var.snapshot_regions
  state_timeout = var.state_timeout
  user_data = var.user_data
  tags = var.tags
  vpc_uuid = var.vpc_uuid
  connect_with_private_ip = var.connect_with_private_ip
  ssh_key_id = var.ssh_key_id
  ssh_private_key_file = var.ssh_private_key_file
}

source "amazon-ebs" "template" {
  access_key = var.aws_access_key
  secret_key =  var.aws_secret_key
  region =  "us-east-1"
  source_ami =  "ami-fce3c696"
  instance_type =  "t2.micro"
  ssh_username =  "ubuntu"
  ami_name =  "packer_AWS {{timestamp}}"
  ami_virtualization_type = string
  ami_users = list(string)
  ami_groups = list(string)
  tags = map(string)
  communicator = var.is_windows ? "winrm" : "ssh"
  force_deregister = true
  winrm_insecure = var.is_windows ? true : false
  winrm_username = var.is_windows ? "Administrator" : null
  winrm_use_ssl = var.is_windows ? true : false
  ssh_username         = var.is_windows ? null : "root"
  ssh_interface        = var.is_windows ? null : "session_manager"
  ssh_password = var.is_windows ? null : "root"
  ssh_port = var.is_windows ? null : 22
}