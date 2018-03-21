variable "cluster_name" {
  default = "example"
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
  default = "Linux Ubuntu 17.10 64-bit"
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
