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
  default = "TLAB-FC-LUN02"
}

variable "IP" {
  default = "192.168.2.60"
}

variable "pool" {
  # default = "resource-pool"
  default = "192.168.2.60/Resources"
  
}

variable "disk_count" {
  description = "Enter the number of disk you want"
  default = 1
}

variable "disk_sizes" {
  description = "List of disk sizes in GB in List"
  type        = list(number)
  default = [ 16 ]
}
