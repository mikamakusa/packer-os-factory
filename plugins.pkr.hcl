packer {
  required_version = ">= 1.7.0"
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/virtualbox"
    }
    vagrant = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/vagrant"
    }
    vsphere = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/vsphere"
    }
    vmware = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/vmware"
    }
    proxmox = {
      version = ">= 1.1.3"
      source  = "github.com/hashicorp/proxmox"
    }
    qemu = {
      version = ">= 1.0.9"
      source  = "github.com/hashicorp/qemu"
    }
    parallels = {
      version = ">= 1.0.3"
      source  = "github.com/hashicorp/parallels"
    }
    oracle = {
      version = ">= 1.0.4"
      source  = "github.com/hashicorp/oracle"
    }
    openstack = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/openstack"
    }
    nutanix = {
      version = ">= 0.3.0"
      source  = "github.com/nutanix-cloud-native/nutanix"
    }
    hyperv = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/hyperv"
    }
    googlecompute = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/googlecompute"
    }
    digitalocean = {
      version = ">= 1.0.4"
      source  = "github.com/digitalocean/digitalocean"
    }
    azure = {
      version = ">= 1.4.2"
      source  = "github.com/digitalocean/azure"
    }
    amazon = {
      version = ">= 1.2.5"
      source  = "github.com/digitalocean/amazon"
    }
  }
}