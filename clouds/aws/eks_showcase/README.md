# Instructions

1. `terraform init`
1. `terraform apply -target "module.eks" -target "aws_instance.bastion"`
1. Use the bastion instance to establish a tunnel to the internal network. Example using [sshuttle](https://sshuttle.readthedocs.io/): `sshuttle -r ubuntu@${BASTION_PUBLIC_IP} 10.11.0.0/16`
1. `terraform apply`

This will create the EKS cluster with a Load Balancer Controller installed.