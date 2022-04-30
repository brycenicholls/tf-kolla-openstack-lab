resource "openstack_blockstorage_volume_v2" "tier2" {
  count = 2
  volume_type = "tier2"
  name = "${format("tier2-vol-%02d", count.index + 1)}"
  size = 500
}

resource "openstack_compute_volume_attach_v2" "attached-01" {
  instance_id = "${openstack_compute_instance_v2.compute[0].id}"
  volume_id   = "${openstack_blockstorage_volume_v2.tier2[0].id}"
}
resource "openstack_compute_volume_attach_v2" "attached-02" {
  instance_id = "${openstack_compute_instance_v2.compute[1].id}"
  volume_id   = "${openstack_blockstorage_volume_v2.tier2[1].id}"
}