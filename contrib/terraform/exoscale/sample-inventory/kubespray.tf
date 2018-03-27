provider "exoscale" {
  version = "~> 0.9.14"
}

variable "cluster_name" {
  default = "example"
}

variable "number_of_bastions" {
  default = 1
}

variable "number_of_k8s_masters" {
  default = 2
}

variable "number_of_k8s_masters_no_etcd" {
  default = 2
}

variable "number_of_etcd" {
  default = 2
}

variable "number_of_k8s_nodes" {
  default = 2
}

variable "public_key_path" {
  description = "the path of the SSH public key"
  default = "~/.ssh/id_rsa.pub"
}

variable "template" {
  description = "the image to use"
  default = "Linux Ubuntu 16.04 LTS 64-bit"
}

variable "zone" {
  default = "ch-dk-2"
}

variable "size" {
  default = "Medium"
}

variable "disk_size" {
  default = "20"
}

module "compute" {
  source = "../../contrib/terraform/exoscale/modules/compute"

  cluster_name                                 = "${var.cluster_name}"
  number_of_bastions                           = "${var.number_of_bastions}"
  number_of_k8s_masters                        = "${var.number_of_k8s_masters}"
  number_of_k8s_masters_no_etcd                = "${var.number_of_k8s_masters_no_etcd}"
  number_of_etcd                               = "${var.number_of_etcd}"
  number_of_k8s_nodes                          = "${var.number_of_k8s_nodes}"
  public_key_path                              = "${var.public_key_path}"
  template                                     = "${var.template}"
  zone                                         = "${var.zone}"
  size                                         = "${var.size}"
  disk_size                                    = "${var.disk_size}"
}
