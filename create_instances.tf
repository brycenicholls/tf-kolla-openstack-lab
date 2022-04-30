# Create kolla instance
resource "openstack_compute_instance_v2" "kolla" {
  name      = "kolla"
  image_id  = var.image_id
  flavor_id = var.flavor_id
  key_pair  = var.key_pair
  security_groups = ["${openstack_compute_secgroup_v2.secgroup_1.name}"]
  network {
    name = "MGMT"
}
  network {
    name = "PROV"
}
  user_data = "${file("kolla.sh")}"
}

# Create computes
resource "openstack_compute_instance_v2" "compute" {
  count = 2
  name  = "${format("compute-%02d", count.index + 1)}"
  image_id  = var.image_id
  flavor_id = "ad5ca079-a1ae-42d1-b86b-f3d1f29f0474"
  key_pair  = var.key_pair
  security_groups = ["${openstack_compute_secgroup_v2.secgroup_1.name}"]

  network {
    name = "PROV"
}

  network {
    name = "TRANSIT"
}
}

# Create controllers
resource "openstack_compute_instance_v2" "controller" {
  count = 3
  name  = "${format("controller-%02d", count.index + 1)}"
  image_id  = var.image_id
  flavor_id = "ad5ca079-a1ae-42d1-b86b-f3d1f29f0474"
  key_pair  = var.key_pair
  security_groups = ["${openstack_compute_secgroup_v2.secgroup_1.name}"]

  network {
    name = "PROV"
}

  network {
    name = "TRANSIT"
}
}
