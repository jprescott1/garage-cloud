## LXD Terraform Module
Easily build and destroy VMs on an Ubuntu server. Made specifically for my homelab and uses default network configuration for now. 

> You must define a storage pool on the host machine before using module. Ensure the pool you create matches the name in variables.tf

> `lxc storage create $POOL_NAME dir`

## Usage


```
module "control-plane" {
  source         = "../modules/lxd-vms"
  instance_count = 1
  name_prefix    = "control-plane"
  cpu            = 4
  memory         = "6GiB"
  volume_size    = "80GiB"
}

module "worker" {
  source         = "../modules/lxd-vms"
  instance_count = 3
  name_prefix    = "control-plane"
  cpu            = 4
  memory         = "6GiB"
  volume_size    = "80GiB"
}

```
