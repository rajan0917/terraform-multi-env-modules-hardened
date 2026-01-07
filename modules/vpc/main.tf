resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge({ "Name" : var.name }, var.tags)
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = length(var.azs) > count.index ? element(var.azs, count.index) : null
  map_public_ip_on_launch = true
  tags                    = { Name = "${var.name}-public-${count.index}" }
}

resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = length(var.azs) > count.index ? element(var.azs, count.index) : null
  tags              = { Name = "${var.name}-private-${count.index}" }
}
resource "aws_nat_gateway" "this" {
 # count         = var.create_nat
  count         = var.create_nat ? length(aws_subnet.public) : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
}
resource "aws_eip" "nat" {
#  count = var.create_nat
#  vpc   = true
  count  = 3
#  domain   = "vpc"
}
