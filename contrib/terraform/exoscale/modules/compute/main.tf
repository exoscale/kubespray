resource "exoscale_ssh_keypair" "k8s" {
  name = "kubernetes-${var.cluster_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "exoscale_security_group" "bastion" {
  name = "${var.cluster_name}-bastion"
  description = "Bastion Server"
}

resource "exoscale_security_group_rule" "bastion_ping" {
  security_group_id = "${exoscale_security_group.bastion.id}"
  cidr = "0.0.0.0/0"
  type = "INGRESS"
  protocol = "ICMP"
  icmp_type = 8
  icmp_code = 0
}

resource "exoscale_security_group_rule" "bastion_ssh" {
  security_group_id = "${exoscale_security_group.bastion.id}"
  cidr = "0.0.0.0/0"
  type = "INGRESS"
  protocol = "TCP"
  start_port = 22
  end_port = 22
}

resource "exoscale_security_group" "k8s_master" {
  name = "${var.cluster_name}-k8s-master"
  description = "Kubernetes Master"
}

resource "exoscale_security_group_rule" "k8s_api_server" {
  security_group_id = "${exoscale_security_group.k8s_master.id}"
  cidr = "0.0.0.0/0"
  start_port = "6443"
  end_port = "6443"
  type = "INGRESS"
  protocol = "TCP"
}

resource "exoscale_security_group" "k8s" {
  name = "${var.cluster_name}-k8s"
  description = "Kubernetes"
}

resource "exoscale_security_group_rule" "k8s_tcp" {
  security_group_id = "${exoscale_security_group.k8s.id}"
  user_security_group_id = "${exoscale_security_group.k8s.id}"
  start_port = "1"
  end_port = "65535"
  type = "INGRESS"
  protocol = "TCP"
}

resource "exoscale_security_group_rule" "k8s_udp" {
  security_group_id = "${exoscale_security_group.k8s.id}"
  user_security_group_id = "${exoscale_security_group.k8s.id}"
  start_port = "1"
  end_port = "65535"
  type = "INGRESS"
  protocol = "UDP"
}

resource "exoscale_security_group_rule" "k8s_ssh" {
  security_group_id = "${exoscale_security_group.k8s.id}"
  cidr = "0.0.0.0/0"
  type = "INGRESS"
  protocol = "TCP"
  start_port = 22
  end_port = 22
}

resource "exoscale_compute" "bastion" {
  count = "${var.number_of_bastions}"
  display_name = "${var.cluster_name}-bastion-${count.index+1}"
  zone = "${var.zone}"
  size = "${var.size}"
  disk_size = "${var.disk_size}"
  template = "${var.template}"
  key_pair = "${exoscale_ssh_keypair.k8s.name}"

  security_groups = [
    "${exoscale_security_group.bastion.name}",
  ]

  tags {
    kubespray_groups = "bastion"
  }
}

resource "exoscale_compute" "k8s_master" {
  count = "${var.number_of_k8s_masters}"
  display_name = "${var.cluster_name}-k8s-master-${count.index+1}"
  zone = "${var.zone}"
  size = "${var.size}"
  disk_size = "${var.disk_size}"
  template = "${var.template}"
  key_pair = "${exoscale_ssh_keypair.k8s.name}"

  security_groups = [
    "${exoscale_security_group.k8s_master.name}",
    "${exoscale_security_group.k8s.name}",
  ]

  tags {
    kubespray_groups = "etcd,kube-master,k8s-cluster,vault"
  }
}

resource "exoscale_compute" "k8s_master_no_etcd" {
  count = "${var.number_of_k8s_masters_no_etcd}"
  display_name = "${var.cluster_name}-k8s-master-ne-${count.index+1}"
  zone = "${var.zone}"
  size = "${var.size}"
  disk_size = "${var.disk_size}"
  template = "${var.template}"
  key_pair = "${exoscale_ssh_keypair.k8s.name}"

  security_groups = [
    "${exoscale_security_group.k8s_master.name}",
    "${exoscale_security_group.k8s.name}"
  ]

  tags {
    kubespray_groups = "kube-master,k8s-cluster,vault"
  }
}

resource "exoscale_compute" "etcd" {
  count = "${var.number_of_etcd}"
  display_name = "${var.cluster_name}-etcd-${count.index+1}"
  zone = "${var.zone}"
  size = "${var.size}"
  disk_size = "${var.disk_size}"
  template = "${var.template}"
  key_pair = "${exoscale_ssh_keypair.k8s.name}"

  security_groups = [
    "${exoscale_security_group.k8s.name}"
  ]

  tags {
    kubespray_groups = "etcd,vault"
  }

  user_data = <<EOF
#cloud-config

package_udpate: true
package_upgrade: true

packages:
- python-pip
EOF
}

resource "exoscale_compute" "k8s_node" {
  count = "${var.number_of_k8s_nodes}"
  display_name = "${var.cluster_name}-k8s-node-${count.index+1}"
  zone = "${var.zone}"
  size = "${var.size}"
  disk_size = "${var.disk_size}"
  template = "${var.template}"
  key_pair = "${exoscale_ssh_keypair.k8s.name}"

  security_groups = [
    "${exoscale_security_group.k8s.name}"
  ]

  tags {
    kubespray_groups = "kube-node,k8s-cluster"
  }
}
