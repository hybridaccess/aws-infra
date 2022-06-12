/*
resource "aws_network_interface" "this" {
  count       = 1
  subnet_id   = aws_subnet.private.id
  private_ips = ["192.168.10.10"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "cassandra" {
  count         = 1
  ami           = "ami-05ad77e76f6b349d6" # eu-west-a
  instance_type = "t2.micro"
  availability_zone = ""
  hibernation = false
  monitoring = false
  disable_api_termination = false
  tags = {
    Name = "cassandra-${count.index}"
  }

  root_block_device {
    delete_on_termination = true
    volume_type = "gp2"
    volume_size = ""
  }


  network_interface {
    network_interface_id = aws_network_interface.this[count.index].id
    device_index         = 0
  }
}
*/

resource "aws_network_interface" "bastion" {
  subnet_id = aws_subnet.public.id

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "bastion" {
  count                   = 1
  ami                     = "ami-05ad77e76f6b349d6" # eu-west-a
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


  network_interface {
    network_interface_id = aws_network_interface.bastion[count.index].id
    device_index         = 0
  }
}
