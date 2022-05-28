# Create a VPC
resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}


resource "aws_subnet" "this" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "cassandra-subnet"
  }
}
