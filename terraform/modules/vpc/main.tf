resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-vpc"
    }
  )
}

# Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-public-subnet-${count.index + 1}"
    }
  )
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-private-subnet-${count.index + 1}"
    }
  )
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-igw"
    }
  )
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  count  = length(var.public_subnet_cidrs) > 0 ? 1 : 0
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-nat-eip"
    }
  )
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnet_cidrs) > 0 ? 1 : 0
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-nat"
    }
  )

  depends_on = [aws_internet_gateway.igw]
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-public-route-table"
    }
  )
}

# Route to Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Route Table Associations for Public Subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Route Table for Private Subnets
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidrs) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-private-route-table"
    }
  )
}

# Route to NAT Gateway
resource "aws_route" "private_nat_gateway" {
  count                  = length(var.private_subnet_cidrs) > 0 ? 1 : 0
  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[0].id
}

# Route Table Associations for Private Subnets
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id
}
