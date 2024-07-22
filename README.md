# k8s-demo

This project demonstrates simple Kubernetes setup using both AWS EKS and Azure AKS.

Kubernetes clusters are created using Terraform.
The example application is deployed using helm.


## Instruction

### AWS

In `./terraform/aws/eks_showcase`:

1. `terraform init`
1. `terraform apply -target "module.eks" -target "aws_instance.bastion"`
1. Use the bastion instance to establish a tunnel to the internal network. Example using [sshuttle](https://sshuttle.readthedocs.io/): `sshuttle -r ubuntu@${BASTION_PUBLIC_IP} 10.11.0.0/16`
1. `terraform apply`

This will create the EKS cluster with a Load Balancer Controller installed.

Run: `aws eks --region <aws_region> update-kubeconfig --name <eks_cluster_name>`

Make sure to pick the correct kube context, e.g. with `kubectx`.

In `./helm`: `helm upgrade --install hello-world hello-world --values hello-world/values-aws.yaml`

### Azure

In `./terraform/azure/aks`:

1. `terraform init`
1. `terraform apply`

This will create the AKS cluster with ingress controller installed. 

Run: `az aks get-credentials --admin --resource-group <rg_name> --name <cluster_name>`

Make sure to pick the correct kube context, e.g. with `kubectx`.

In `./helm`: `helm upgrade --install hello-world hello-world --values hello-world/values-azure.yaml`
