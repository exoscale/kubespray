# Kubernetes on Exoscale with Terraform

Provision a Kubernetes cluster with Terraform on Exoscale.

## Status

This will install a Kubernetes cluster on the Exocale Cloud provider.

## Approach

The Terraform configuration inspeccts variables found in [variables.tf](variables.tf) to create the resources. There is a [python script](../terraform.py) that reads the generated `.tfstate` file to build the dynamic inventory that is consumed by the main ansible script to actually install Kubernetes.

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
