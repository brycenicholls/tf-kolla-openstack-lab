#Create MGMT network
resource "openstack_networking_network_v2" "MGMT" {
  name           = "MGMT"
  admin_state_up = "true"
}

#Create a subnet and attach to MGMT
resource "openstack_networking_subnet_v2" "mgmt_sub" {
  name       = "mgmt_sub"
  network_id = "${openstack_networking_network_v2.MGMT.id}"
  cidr       = "10.1.1.0/24"
  allocation_pool {
    start = "10.1.1.20"
    end = "10.1.1.200"
  }
  ip_version = 4
  dns_nameservers = ["1.1.1.1"]
}

#Create PROV network
resource "openstack_networking_network_v2" "PROV" {
  name           = "PROV"
  admin_state_up = "true"
}

#Create a subnet and attach to PROV
resource "openstack_networking_subnet_v2" "prov_sub" {
  name       = "prov_sub"
  network_id = "${openstack_networking_network_v2.PROV.id}"
  cidr       = "10.1.2.0/24"
  allocation_pool {
    start = "10.1.2.20"
    end = "10.1.2.200"
  }
  ip_version = 4
  dns_nameservers = ["1.1.1.1"]
}

#Create TRANSIT network
resource "openstack_networking_network_v2" "TRANSIT" {
  name           = "TRANSIT"
  admin_state_up = "true"
}

#Create a subnet and attach to TRANSIT
resource "openstack_networking_subnet_v2" "transit_sub" {
  name       = "transit_sub"
  network_id = "${openstack_networking_network_v2.TRANSIT.id}"
  cidr       = "10.1.3.0/24"
  allocation_pool {
    start = "10.1.3.20"
    end = "10.1.3.200"
  }
  ip_version = 4
  dns_nameservers = ["1.1.1.1"]
}

# router create  
resource "openstack_networking_router_v2" "MGMT" {
  name                = "MGMT"
  admin_state_up      = true
  external_network_id = var.external_network_name
}

resource "openstack_networking_router_v2" "PROV" {
  name                = "PROV"
  admin_state_up      = true
  external_network_id = var.external_network_name
}

# attach MGMT router to MGMT network
resource "openstack_networking_router_interface_v2" "mgmt_router_interface" {
  router_id = "${openstack_networking_router_v2.MGMT.id}"
  subnet_id = openstack_networking_subnet_v2.mgmt_sub.id
}

# attach PROV router to PROV network
resource "openstack_networking_router_interface_v2" "prov_router_interface" {
  router_id = "${openstack_networking_router_v2.PROV.id}"
  subnet_id = openstack_networking_subnet_v2.prov_sub.id
}

# floating ip create -1  
resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = "internet"
}

resource "openstack_compute_floatingip_associate_v2" "floatip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.floatip_1.address}"
  instance_id = "${openstack_compute_instance_v2.kolla.id}"
}