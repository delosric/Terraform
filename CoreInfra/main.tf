provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "crc_vpc" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "crc_vpc"
  }
}

resource "aws_subnet" "crc_subnet" {
  vpc_id                  = "${aws_vpc.crc_vpc.id}"
  map_public_ip_on_launch = true
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-1a"

  tags {
    Name = "crc_subnet"
  }
}

resource "aws_internet_gateway" "crc_gw" {
  vpc_id = "${aws_vpc.crc_vpc.id}"

  tags {
    Name = "crc_gateway"
  }
}

resource "aws_route_table" "crc_r" {
  vpc_id = "${aws_vpc.crc_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.crc_gw.id}"
  }

  tags {
    Name = "crc_route"
  }
}

resource "aws_route_table_association" "crc_a" {
  subnet_id      = "${aws_subnet.crc_subnet.id}"
  route_table_id = "${aws_route_table.crc_r.id}"
}

