resource "aws_network_interface" "this" {
  count       = 1
  subnet_id   = aws_subnet.this.id
  private_ips = ["192.168.10.10"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "this" {
  count         = 1
  ami           = "ami-0d729d2846a86a9e7" # eu-west-a
  instance_type = "t2.micro"
  tags = {
    Name = "cassandra-${count.index}"
  }

  network_interface {
    network_interface_id = aws_network_interface.this[count.index].id
    device_index         = 0
  }
}