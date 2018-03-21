# Kubernetes on Exoscale with Terraform

Provision a Kubernetes cluster with Terraform on Exoscale.

## Status

This will install a Kubernetes cluster on the Exocale Cloud provider.

## Approach

The Terraform configuration inspects variables found in [variables.tf](variables.tf) to create the resources. There is a [python script](../terraform.py) that reads the generated `.tfstate` file to build the dynamic inventory that is consumed by the main ansible script to actually install Kubernetes.

## Networking

...

### Kubernetes Nodes

- Master nodes with etcd
- Master nodes without etcd
- Standalone ectd hosts
- Kubernetes worker nodes

Note than the Ansible script will report an invalid configuration if you wind up with an even number of ETCD instances since that is not a valid configuration.

### GlusterFS

...

## Requirements

- [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
- [Install Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)
- you already have a suitable OS image in Glance
- you already have a floating IP pool created
- you have security groups enabled
- you have a pair of keys generated that can be used to secure the new hosts

## Module Architecture

...

## Terraform

Terraform will be used to provision all the Exoscale resources with base software as appropriate.

### Configuration

#### Inventory files

Create an inventory directory for your cluster by copying the existing sample and linking the `hosts` script (used to build the inventory based on the Terraform state):

```console
$ cp -LRp contrib/terraform/exoscale/sample-inventory inventory/$CLUSTER
$ cd inventory/$CLUSTER
$ ln -s ../../contrib/terraform/exoscale/hosts
```

This will be the base for the subsequent Terraform commands.

#### Exoscale access and credentials

The terraform provider reads a `cloudstack.ini` file.

```ini
[cloudstack]
key = "EXO..."
secret = "..."
```

#### Cluster variables


| Variable | Description |
|----------|-------------|
| `cluster_name` | ... |

### Initialization

```console
$ terraform init
```

### Provisioning the cluster

```console
$ terraform apply -var-file=cluster.tf
```

### Destroying the cluster


```console
$ terraform destroy -var-file=cluster.tf
```

## Ansible

### SSH

...

```console
$ eval $(ssh-agent -s)
$ ssh-add ~/.ssh/id_rsa
```

### Ping

Make sure you can connect to the hosts.

```console
$ ansible -i hosts -m ping all
example-k8s-master-1 | SUCCESS => {
        "changed": false,
                "ping": "pong"
}
example-etcd-1 | SUCCESS => {
        "changed": false,
                "ping": "pong"
}
example-k8s-node-1 | SUCCESS => {
        "changed": false,
                "ping": "pong"
}
example-k8s-master-ne-1 | SUCCESS => {
        "changed": false,
                "ping": "pong"
}
```
