# VPC
resource "aws_vpc" "tf_main_vpc" {
  cidr_block = var.main_vpc_cidr

  tags = {
    vpc  = "main"
    Name = "tf-vpc-main"
  }
}

# Internet Gateway para a VPC
resource "aws_internet_gateway" "tf_main_igw" {
  vpc_id = aws_vpc.tf_main_vpc.id

  tags = {
    Name = "tf-igw-main"
  }
}


# Subredes Publicas
resource "aws_subnet" "public-a" {
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-subnet-public-a"
  }
}

resource "aws_eip" "elastic-ip-a" {
}

resource "aws_nat_gateway" "nat-public-a" {
  allocation_id = aws_eip.elastic-ip-a.id
  subnet_id     = aws_subnet.public-a.id
  depends_on    = [aws_internet_gateway.tf_main_igw]
  tags = {
    Name = "tf-gw-nat-a"
  }
}

resource "aws_subnet" "public-b" {
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-subnet-public-b"
  }
}

resource "aws_eip" "elastic-ip-b" {
}

resource "aws_nat_gateway" "nat-public-b" {
  allocation_id = aws_eip.elastic-ip-b.id
  subnet_id     = aws_subnet.public-b.id
  depends_on    = [aws_internet_gateway.tf_main_igw]
  tags = {
    Name = "tf-gw-nat-b"
  }
}

resource "aws_subnet" "public-c" {
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-subnet-public-c"
  }
}

resource "aws_eip" "elastic-ip-c" {
}

resource "aws_nat_gateway" "nat-public-c" {
  allocation_id = aws_eip.elastic-ip-c.id
  subnet_id     = aws_subnet.public-c.id
  depends_on    = [aws_internet_gateway.tf_main_igw]
  tags = {
    Name = "tf-gw-nat-c"
  }
}



# Subnets Privadas de Aplicacao
resource "aws_subnet" "app-private-a" {
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-app-subnet-private-a"
  }
}


resource "aws_subnet" "app-private-b" {
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-app-subnet-private-b"
  }
}


resource "aws_subnet" "app-private-c" {
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1c"
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-app-subnet-private-c"
  }
}



# Subnets Privadas de Banco de Dados
resource "aws_subnet" "data-private-a" {
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1a"
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-data-subnet-private-a"
  }
}


resource "aws_subnet" "data-private-b" {
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = "us-east-1b"
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-app-subnet-private-b"
  }
}


resource "aws_subnet" "data-private-c" {
  vpc_id            = aws_vpc.tf_main_vpc.id
  cidr_block        = "10.0.9.0/24"
  availability_zone = "us-east-1c"
  depends_on        = [aws_vpc.tf_main_vpc]
  tags = {
    Name = "tf-data-subnet-private-c"
  }
}


# ROTAS ===========================================================================

# Rotas publicas
resource "aws_route_table" "tf-route-public" {
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

resource "aws_route_table_association" "tf-route-public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.tf-route-public.id
}

resource "aws_route_table_association" "tf-route-public-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.tf-route-public.id
}

resource "aws_route_table_association" "tf-route-public-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.tf-route-public.id
}



# Rotas para a aplicação
resource "aws_route_table" "tf-route-app-a" {
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
}

resource "aws_route_table_association" "tf-route-app-a" {
  subnet_id      = aws_subnet.app-private-a.id
  route_table_id = aws_route_table.tf-route-app-a.id
}

resource "aws_route_table" "tf-route-app-b" {
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
}

resource "aws_route_table_association" "tf-route-app-b" {
  subnet_id      = aws_subnet.app-private-b.id
  route_table_id = aws_route_table.tf-route-app-b.id
}

resource "aws_route_table" "tf-route-app-c" {
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
}

resource "aws_route_table_association" "tf-route-app-c" {
  subnet_id      = aws_subnet.app-private-c.id
  route_table_id = aws_route_table.tf-route-app-c.id
}



# Rotas para Banco de dados
resource "aws_route_table" "tf-route-data" {
  vpc_id = aws_vpc.tf_main_vpc.id
  route {
    cidr_block = var.main_vpc_cidr
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "tf-route-data-a" {
  subnet_id      = aws_subnet.data-private-a.id
  route_table_id = aws_route_table.tf-route-data.id
}

resource "aws_route_table_association" "tf-route-data-b" {
  subnet_id      = aws_subnet.data-private-b.id
  route_table_id = aws_route_table.tf-route-data.id
}

resource "aws_route_table_association" "tf-route-data-c" {
  subnet_id      = aws_subnet.data-private-c.id
  route_table_id = aws_route_table.tf-route-data.id
}