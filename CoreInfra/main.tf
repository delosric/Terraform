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
  vpc_id            = "${aws_vpc.crc_vpc.id}"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1a"

  tags {
    Name = "crc_subnet"
  }
}
