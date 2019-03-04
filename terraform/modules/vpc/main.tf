# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "${ var.vpc["cidr_vpc"] }"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-vpc"
  }
}

# Subnet
resource "aws_subnet" "front_a" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_front_a"] }"
  availability_zone = "${ var.aws["region"] }a"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_a"] }-front-a"
  }
}

resource "aws_subnet" "front_c" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_front_c"] }"
  availability_zone = "${ var.aws["region"] }c"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_c"] }-front-c"
  }
}

resource "aws_subnet" "front_d" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_front_d"] }"
  availability_zone = "${ var.aws["region"] }d"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-front-d"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_public_a"] }"
  availability_zone = "${ var.aws["region"] }a"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_a"] }-public-a"
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_public_c"] }"
  availability_zone = "${ var.aws["region"] }c"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_c"] }-public-c"
  }
}

resource "aws_subnet" "public_d" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_public_d"] }"
  availability_zone = "${ var.aws["region"] }d"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-public-d"
  }
}

resource "aws_subnet" "private_web_a" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_private_web_a"] }"
  availability_zone = "${ var.aws["region"] }a"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_a"] }-private-web-a"
  }
}

resource "aws_subnet" "private_web_c" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_private_web_c"] }"
  availability_zone = "${ var.aws["region"] }c"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_c"] }-private-web-c"
  }
}

resource "aws_subnet" "private_web_d" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_private_web_d"] }"
  availability_zone = "${ var.aws["region"] }d"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-private-web-d"
  }
}

resource "aws_subnet" "private_data_a" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_private_data_a"] }"
  availability_zone = "${ var.aws["region"] }a"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_a"] }-private-data-a"
  }
}

resource "aws_subnet" "private_data_c" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_private_data_c"] }"
  availability_zone = "${ var.aws["region"] }c"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_c"] }-private-data-c"
  }
}

resource "aws_subnet" "private_data_d" {
  vpc_id            = "${ aws_vpc.vpc.id }"
  cidr_block        = "${ var.vpc["cidr_private_data_d"] }"
  availability_zone = "${ var.aws["region"] }d"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-private-data-d"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${ aws_vpc.vpc.id }"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-igw"
  }
}

# Nat Gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = "${ var.eip["nat_gateway_id"] }"
  subnet_id     = "${ aws_subnet.front_d.id }"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-ngw"
  }
}

# Route Table
resource "aws_route_table" "front" {
  vpc_id       = "${ aws_vpc.vpc.id }"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${ aws_internet_gateway.igw.id }"
  }
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-rtb-front"
  }
}

resource "aws_route_table" "public" {
  vpc_id       = "${ aws_vpc.vpc.id }"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${ aws_internet_gateway.igw.id }"
  }
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-rtb-public"
  }
}

resource "aws_route_table" "private_web" {
  vpc_id       = "${ aws_vpc.vpc.id }"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${ aws_nat_gateway.ngw.id }"
  }
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-rtb-private-web"
  }
}

resource "aws_route_table" "private_data" {
  vpc_id       = "${ aws_vpc.vpc.id }"
  tags {
    Name = "${ var.project["name"] }-${ var.env["zone_d"] }-rtb-private-data"
  }
}

# Route Table Association
resource "aws_route_table_association" "front_a" {
  subnet_id      = "${ aws_subnet.front_a.id }"
  route_table_id = "${ aws_route_table.front.id }"
}

resource "aws_route_table_association" "front_c" {
  subnet_id      = "${ aws_subnet.front_c.id }"
  route_table_id = "${ aws_route_table.front.id }"
}

resource "aws_route_table_association" "front_d" {
  subnet_id      = "${ aws_subnet.front_d.id }"
  route_table_id = "${ aws_route_table.front.id }"
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = "${ aws_subnet.public_a.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

resource "aws_route_table_association" "public_c" {
  subnet_id      = "${ aws_subnet.public_c.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

resource "aws_route_table_association" "public_d" {
  subnet_id      = "${ aws_subnet.public_d.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

resource "aws_route_table_association" "private_web_a" {
  subnet_id      = "${ aws_subnet.private_web_a.id }"
  route_table_id = "${ aws_route_table.private_web.id }"
}

resource "aws_route_table_association" "private_web_c" {
  subnet_id      = "${ aws_subnet.private_web_c.id }"
  route_table_id = "${ aws_route_table.private_web.id }"
}

resource "aws_route_table_association" "private_web_d" {
  subnet_id      = "${ aws_subnet.private_web_d.id }"
  route_table_id = "${ aws_route_table.private_web.id }"
}

resource "aws_route_table_association" "private_data_a" {
  subnet_id      = "${ aws_subnet.private_data_a.id }"
  route_table_id = "${ aws_route_table.private_data.id }"
}

resource "aws_route_table_association" "private_data_c" {
  subnet_id      = "${ aws_subnet.private_data_c.id }"
  route_table_id = "${ aws_route_table.private_data.id }"
}

resource "aws_route_table_association" "private_data_d" {
  subnet_id      = "${ aws_subnet.private_data_d.id }"
  route_table_id = "${ aws_route_table.private_data.id }"
}

