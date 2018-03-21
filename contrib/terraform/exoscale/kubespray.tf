provider "exoscale" {
  version = "~> 0.9.14"
}

module "compute" {
  source = "modules/compute"

  cluster_name                                 = "${var.cluster_name}"
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
