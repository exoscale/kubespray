# your Kubernetes cluster name here
cluster_name = "i-didnt-read-the-docs"

# SSH key to use for access to nodes
public_key_path = "~/.ssh/id_rsa.pub"

# image to use for bastion, masters, standalone etcd instances, and nodes
image = "<image name>"

# standalone etcds
number_of_etcd = 0

# masters
number_of_k8s_masters = 1
number_of_k8s_masters_no_etcd = 0

# nodes
number_of_k8s_nodes = 2
