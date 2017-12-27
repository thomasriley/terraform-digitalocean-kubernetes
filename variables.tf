variable "do_region" {
  default     = "lon1"
  description = "The DigitalOcean Region to launch the cluster in"
}

variable "do_image" {
  default     = "centos-7-x64"
  description = "The DigitalOcean droplet image to use for all nodes"
}

variable "do_droplet_size_master" {
  default     = "2gb"
  description = "The DigitalOcean droplet size to use for master nodes"
}

variable "do_droplet_size_minion" {
  default     = "2gb"
  description = "The DigitalOcean droplet size to use for minion nodes"
}

variable "cluster_name" {
  default     = "k8"
  description = "The name of the cluster, this is typically used for tagging resources in DigitalOcean"
}

variable "cluster_token" {
  default     = "aad1f4.4cf2c4612e2f0235"
  description = "The Token to use for cluserting within Kubernets, do not use the default for anything other than proof of concept work!"
}

variable "ssh_public_key" {
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8vMrLxiZmbRyPQwiJbzQ0hNKt0pAPiJ8GkW01T/7FX0Id0XmBSo75V9ewScX7hyHvkMt7Acxcpdm4Z5XOJyCyEU/TYAHD6sQ4x0mwJkMS45zWhtPg3NxVLZVXFNj0OlAVa0hKWS5+Im52dPUX6/npKCoh/3Y3y08wvj7ft15tkzNhFiPoVn5BCUrZ8ValWYM1iyryFaRFSLv2M0+vBmsAUBmfuPz5LLUOp3otgU2uWdxfVBx3LW92ev/JAAT2nzXonoahjh30KQefZiC82kuAUGryukk0OKDtV3rpfp6N2sxyPMa7DuZOPt42Ld6VmalL0n2BKl3ta+cqnLUQL2NV"
  description = "The SSH key to use for droplets in the cluster, do not use the default for anything other than proof of concept work!"
}

variable "number_of_minions" {
  default     = 2
  description = "The number of minions to launch"
}
