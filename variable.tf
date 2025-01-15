variable "vsphere_user" {
  default = "administrator@vsphere.local"
  description = "Provide user name"
  sensitive = true
}

variable "vsphere_password" {
  default = "Admin@123"
  description = "Provide password"
  sensitive = true
}

variable "vsphere_server" {
    default = "192.168.2.30"
}

variable "network" {
  default = "VM Network"
}

variable "datacenter" {
  default = "Datacenter"
}

variable "datastore" {
    default = "Huwaei's"
}

variable "IP" {
  default = "192.168.2.60"
}

variable "pool" {
    # default = "resource-pool"
    default = "192.168.2.106/Resources"
  
}

variable "guest_id" {
  default = "ubuntu64Guest"
}