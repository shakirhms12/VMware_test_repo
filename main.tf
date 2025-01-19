provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
  api_timeout          = 30
}

data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = "newvm14"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# data "vsphere_host" "esxi_host" {
#   name          = var.IP
#   datacenter_id = data.vsphere_datacenter.datacenter.id
# }

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.pool
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "hcl"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 2
  memory           = 4096
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id = data.vsphere_network.network.id
    #adapter_type = data.vsphere_virtual_machine.template.network_interface_type[0]
  }

  dynamic "disk" {
    for_each = range(var.disk_count)
    content {
      label = "disk${disk.value}"
      size  = var.disk_sizes[disk.value]
      unit_number = disk.value
    }
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    customize {
      linux_options {
        host_name = "Test"
        domain    = ""
      }
      network_interface {
       ipv4_address = "192.168.3.232"
       ipv4_netmask = 24
      }
        ipv4_gateway = "192.168.3.1"
       dns_server_list = ["192.168.3.1"]
    }
  }

  extra_config = {
    "guestinfo.userdata" = base64encode(file("./userdata.yaml"))
    "guestinfo.userdata.encoding" = "base64"
  }
}  