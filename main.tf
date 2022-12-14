data "ibm_pi_key" "ssh_key" {
  pi_key_name          = "ssh-poc"
  pi_cloud_instance_id = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
}

data "ibm_pi_network" "network2" {
  pi_network_name = "testvpn"
  pi_cloud_instance_id = "42175bd4-dc42-4ce0-ac6f-bc55caac4b7c"
}

data "ibm_pi_image" "power_image" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_image_name        = var.image_name
}

resource "ibm_pi_instance" "test-instance" {
  pi_cloud_instance_id = local.cloud_instance_id
  pi_memory            = "5"
  pi_processors        = "0.25"
  pi_instance_name     = var.instancename
  pi_proc_type         = "shared"
  pi_image_id          = data.ibm_pi_image.power_image.id
  pi_key_pair_name     = data.ibm_pi_key.ssh_key.id
  pi_sys_type          = "s922"
  pi_storage_type      = "tier3"

    pi_network {
    network_id  = data.ibm_pi_network.network2.id
  }  
}
