# VPC
resource "aws_vpc" "tf_main_vpc" {
  cidr_block = var.main_vpc_cidr

  tags = {
    vpc  = "main"
    Name = var.main_vpc_name
  }
}

# Internet Gateway para a VPC
resource "aws_internet_gateway" "tf_main_igw" {
  vpc_id = aws_vpc.tf_main_vpc.id

  tags = {
    Name = "tf-igw-main"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = var.number_of_zones
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-subnet-public-${var.availability_zones_names[count.index]}"
  }
}

# NAT Gateways and EIPs
resource "aws_eip" "elastic_ip" {
  count = var.number_of_zones
  tags = {
    Name = "tf-elastic-ip-${count.index}"
  }
}

resource "aws_nat_gateway" "nat_public" {
  count         = var.number_of_zones
  allocation_id = aws_eip.elastic_ip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.tf_main_igw]
  tags = {
    Name = "tf-gw-nat-${var.availability_zones_names[count.index]}"
  }
}

# Private App Subnets
resource "aws_subnet" "private_app" {
  count             = var.number_of_zones
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = var.private_app_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-app-subnet-private-${var.availability_zones_names[count.index]}"
  }
}

# Private Data Subnets
resource "aws_subnet" "private_data" {
  count             = var.number_of_zones
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = var.private_data_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-data-subnet-private-${var.availability_zones_names[count.index]}"
  }
}

# Route Tables
# Public Routes
resource "aws_route_table" "route_public" {
  vpc_id     = aws_vpc.tf_main_vpc.id
  depends_on = [aws_internet_gateway.tf_main_igw]

  route {
    cidr_block = var.main_vpc_cidr
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_main_igw.id
  }

  tags = {
    Name = "tf-route-public"
  }
}

resource "aws_route_table_association" "route_public" {
  count          = var.number_of_zones
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.route_public.id
}

# Private App Routes
resource "aws_route_table" "route_app" {
  count      = var.number_of_zones
  vpc_id     = aws_vpc.tf_main_vpc.id
  depends_on = [aws_nat_gateway.nat_public]

  route {
    cidr_block = var.main_vpc_cidr
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_public[count.index].id
  }

  tags = {
    Name = "tf-route-app-${var.availability_zones_names[count.index]}"
  }
}

resource "aws_route_table_association" "route_app" {
  count          = var.number_of_zones
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.route_app[count.index].id
}

# Private Data Routes
resource "aws_route_table" "route_data" {
  vpc_id = aws_vpc.tf_main_vpc.id

  route {
    cidr_block = var.main_vpc_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "tf-route-data"
  }
}

resource "aws_route_table_association" "route_data" {
  count          = var.number_of_zones
  subnet_id      = aws_subnet.private_data[count.index].id
  route_table_id = aws_route_table.route_data.id
}
