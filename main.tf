data "ibm_pi_key" "dskey" {
  pi_cloud_instance_id = local.pid
  pi_key_name          = var.sshkeyname
}
data "ibm_pi_image" "ds_image" {
  pi_image_name        = var.image
  pi_cloud_instance_id = local.pid
}
data "ibm_pi_network" "power_network" {
  count                = 2
  pi_cloud_instance_id = local.pid
  pi_network_name      = var.network_name1
  pi_network_name      = var.network_name2
  }
resource "ibm_pi_instance" "instance" {
  pi_cloud_instance_id = local.pid
  pi_memory            = var.memory
  pi_processors        = var.processors
  pi_instance_name     = var.instance_name
  pi_proc_type         = var.processor_type
  pi_image_id          = data.ibm_pi_image.ds_image.id
  pi_key_pair_name     = data.ibm_pi_key.dskey.id
  pi_sys_type          = var.sys_type
  pi_network {
    network_id = data.ibm_pi_network.power_network.id
  }
}
