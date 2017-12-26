# Create tags for tagging resources
resource "digitalocean_tag" "kubernetes_master" {
  name = "kubernetes-master-${var.cluster_name}"
}

resource "digitalocean_tag" "kubernetes_minion" {
  name = "kubernetes-minion-${var.cluster_name}"
}

# Create a new SSH key
resource "digitalocean_ssh_key" "default" {
  name       = "${var.cluster_name} Key"
  public_key = "${var.ssh_public_key}"
}

data "template_file" "master_bootstrap" {
  template = "${file("${path.module}/etc/scripts/master.sh.tpl")}"

  vars {
    cluster_token = "${var.cluster_token}"
  }
}

# Create master instance(s)
resource "digitalocean_droplet" "master" {
  count               = 1
  image               = "${var.do_image}"
  name                = "${var.cluster_name}-master-${count.index}"
  region              = "${var.do_region}"
  size                = "${var.do_droplet_size_master}"
  private_networking  = false
  ssh_keys            = ["${digitalocean_ssh_key.default.fingerprint}"]
  tags                = ["${digitalocean_tag.kubernetes_master.id}"]
  user_data           = "${data.template_file.master_bootstrap.rendered}"

  provisioner "remote-exec" {
    inline = [
      "while [ ! -f /tmp/script_finished ]; do sleep 2; done",
    ]
  }
}

data "template_file" "minion_bootstrap" {
  template = "${file("${path.module}/etc/scripts/minion.sh.tpl")}"

  vars {
    cluster_token = "${var.cluster_token}"
    master_ip = "${digitalocean_droplet.master.ipv4_address}"
  }
}

# Create node instance(s)
resource "digitalocean_droplet" "minion" {
  count               = "${var.number_of_minions}"
  image               = "${var.do_image}"
  name                = "${var.cluster_name}-minion-${count.index}"
  region              = "${var.do_region}"
  size                = "${var.do_droplet_size_minion}"
  private_networking  = false
  ssh_keys            = ["${digitalocean_ssh_key.default.fingerprint}"]
  tags                = ["${digitalocean_tag.kubernetes_minion.id}"]
  user_data           = "${data.template_file.minion_bootstrap.rendered}"
  depends_on          = ["digitalocean_droplet.master"]

  provisioner "remote-exec" {
    inline = [
      "while [ ! -f /tmp/script_finished ]; do sleep 2; done",
    ]
  }
}
