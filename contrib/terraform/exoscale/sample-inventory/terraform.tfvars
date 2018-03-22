# your Kubernetes cluster name here
cluster_name = "i-didnt-read-the-docs"

# SSH key to use for access to nodes
public_key_path = "~/.ssh/id_rsa.pub"

# image to use for bastion, masters, standalone etcd instances, and nodes
image = "<image name>"

# bastions
number_of_bastions = 2

# standalone etcds
number_of_etcd = 2

# masters
number_of_k8s_masters = 2
number_of_k8s_masters_no_etcd = 2

# nodes
number_of_k8s_nodes = 2
