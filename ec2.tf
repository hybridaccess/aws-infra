resource "aws_network_interface" "this" {
  count           = 2
  subnet_id       = aws_subnet.private.id
  security_groups = [aws_security_group.this.id]

  tags = {
    Name = "primary_network_interface_${count.index}"
  }
}

resource "aws_instance" "cassandra" {
  count                   = 3
  ami                     = "ami-0bd2099338bc55e6d" # eu-west-a
  instance_type           = "t2.micro"
  availability_zone       = "eu-west-2a"
  hibernation             = false
  monitoring              = false
  disable_api_termination = false
  tags = {
    Name = "cassandra-0${count.index}"
  }

  root_block_device {
    delete_on_termination = true
    volume_type           = "gp2"
    volume_size           = "30"
  }

  key_name = aws_key_pair.bastion.key_name

  network_interface {
    network_interface_id = aws_network_interface.this[count.index].id
    device_index         = 0
  }
}

resource "aws_network_interface" "bastion" {
  count           = 1
  subnet_id       = aws_subnet.public.id
  security_groups = [aws_security_group.this.id]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "bastion" {
  count                   = 1
  ami                     = "ami-0bd2099338bc55e6d" # eu-west-a
  instance_type           = "t2.micro"
  availability_zone       = "eu-west-2a"
  hibernation             = false
  monitoring              = false
  disable_api_termination = false
  tags = {
    Name = "bastion-0${count.index}"
  }

  root_block_device {
    delete_on_termination = true
    volume_type           = "gp2"
    volume_size           = "30"
  }

  key_name = aws_key_pair.bastion.key_name


  network_interface {
    network_interface_id = aws_network_interface.bastion[count.index].id
    device_index         = 0
  }
}


// tls private key
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion" {
  public_key = tls_private_key.rsa.public_key_openssh
}

data "azurerm_key_vault" "this" {
  name                = "bootstrap-common-kv"
  resource_group_name = "terraform-bootstrap"
}

resource "azurerm_key_vault_secret" "ec2_private_key" {
  key_vault_id = data.azurerm_key_vault.this.id
  name         = "ec2-private-key"
  value        = tls_private_key.rsa.private_key_pem
}

resource "azurerm_key_vault_secret" "ec2_public_key" {
  key_vault_id = data.azurerm_key_vault.this.id
  name         = "ec2-public-key"
  value        = tls_private_key.rsa.public_key_openssh
}