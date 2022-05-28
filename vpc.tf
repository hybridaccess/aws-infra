# Create a VPC
resource "aws_vpc" "this" {
  cidr_block = "192.168.10.0/24"
  tags = {
    name = "cassandra-vpc"
  }
}


resource "aws_subnet" "this" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.10.0/26"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "cassandra-subnet"
  }
}
