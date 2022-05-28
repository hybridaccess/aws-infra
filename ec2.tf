resource "aws_network_interface" "this" {
  subnet_id   = aws_subnet.this.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "this" {
  ami           = "ami-005e54dee72cc1d00" # eu-west-a
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.this.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}