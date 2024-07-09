data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


data "local_file" "public_key" {
  filename = var.public_key_file
}

resource "aws_key_pair" "bastion" {
  key_name   = "${var.name_prefix}-key"
  public_key = data.local_file.public_key.content
}

module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/ssh"
  version = "~> 5.1.0"

  name   = "${var.name_prefix}-bastion"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "access_from_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.1.0"
  name    = "${var.name_prefix}-access-from-bastion"
  vpc_id  = module.vpc.vpc_id
  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "all-all"
      source_security_group_id = module.bastion_sg.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  subnet_id     = module.vpc.public_subnets[0]
  instance_type = "t3.nano"
  key_name      = aws_key_pair.bastion.key_name
  vpc_security_group_ids = [
    module.bastion_sg.security_group_id,
  ]
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 20
    encrypted   = true
  }

  tags = {
    Name = "${var.name_prefix}-bastion"
  }
  volume_tags = {
    Name = "${var.name_prefix}-bastion"
  }

  lifecycle {
    ignore_changes = [ami]
  }
}