variable "key_pair" {
    description = "The keypair to be used."
    default  = "mymac"
}

variable "network_name" {
    description = "The network to be used."
    default  = ""
}

variable "external_network_name" {
    description = "The id of the external network"
    default = "82e473e2-e2b1-4130-8749-17e7ed488124"
}

variable "instance_name" {
    description = "The Instance Name to be used."
    default  = ""
}

variable "image_id" {
    description = "The image ID to be used."
    default  = "2fd3b2e1-7efd-4040-b648-dccfd1e8b63a"
}

variable "flavor_id" {
    description = "The flavor id to be used."
    default  = "64349655-65a1-4cd6-b28e-e45120b02875"
}

variable "instance_num" {
    description = "The Number of instances to be created."
    default  = ""
}

variable "floating_ip_pool" {
    description = "The pool to be used to get floating ip"
    default = "internet"
}

variable "security_groups" {
    description = "List of security group"
    type = list
    default = ["default"]
}