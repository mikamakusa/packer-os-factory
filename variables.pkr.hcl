variable "plugin" {
  type = string
  description = "Define the plugin you want to use"

  validation {
    condition = contains(["virtualbox-iso", "vagrant", "vsphere-iso", "vmware-iso", "proxmox-iso", "qemu", "parallels-iso", "oracle-classic", "openstack", "nutanix", "hyperv-iso", "googlecompute", "digitalocean", "azure-arm", "amazon-ebs"], var.plugin)
    error_message = "Allowed values : virtualbox-iso, vagrant, vsphere-iso, vmware-iso, proxmox-iso, qemu, parallels-iso, oracle-classic, openstack, nutanix, hyperv-iso, googlecompute, digitalocean, azure-arm, amazon-ebs"
  }
}

variable "is_windows" {
  type = bool
  default = false
  description = "Determines to set setting for Windows or Linux"
}

variable "api_token" {
  type = string
  default = null
  description = "The client TOKEN to use to access your account."
}
variable "region" {
  type = string
  description = "The name (or slug) of the region to launch the droplet in."
  default = null
}
variable "size" {
  type = string
  description = "The name (or slug) of the droplet size to use."
  default = null
}
variable "image" {
  type = string
  default = null
  description = "The name (or slug) of the base image to use."
}
variable "api_url" {
  type = 
}
variable "private_networking" {
  type = 
}
variable "monitoring" {
  type = 
}
variable "droplet_agent" {
  type = 
}
variable "droplet_name" {
  type = 
}
variable "ipv6" {
  type = 
}
variable "snapshot_name" {
  type = 
}
variable "snapshot_regions" {
  type = 
}
variable "state_timeout" {
  type = 
}
variable "user_data" {
  type = 
}
variable "user_data_file" {
  type = 
}
variable "tags" {
  type = 
}
variable "vpc_uuid" {
  type = 
}
variable "connect_with_private_ip" {
  type = 
}
variable "ssh_key_id" {
  type = 
}
variable "ssh_private_key_file" {
  type = 
}