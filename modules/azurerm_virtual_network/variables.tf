variable "virtual_network_name" {
  description = "This is the virtual network name"
  type = string
}

variable "virtual_network_location" {
    description = "This is the virtual network location"
  
}

variable "resource_group_name" {
description = "This is the resource group name"
type = string
  
}

variable "address_space" {
  description = "This is address space"
  type = list(string)
}
