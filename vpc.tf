# Create a VPC
resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "cassandra-vpc"
  }
}


resource "aws_subnet" "this" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "10.10.0.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "cassandra-subnet"
  }
}
