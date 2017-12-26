# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {
  default = ""
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

module "kubernetes_cluster" {
  source = "../../"
  cluster_name = "test-k8"
}
