resource "aws_eip" "eip" {
  for_each = var.vpc_info.cidr_blocks_public

  tags = {
    "Name" = "${var.common_info.service_name}-${each.key}-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  for_each = var.vpc_info.cidr_blocks_public

  allocation_id = aws_eip.eip[each.key].id
  subnet_id     = aws_subnet.subnets_public[each.key].id

  tags = {
    Name = "${var.common_info.service_name}-${each.key}-nat"
  }

  depends_on = [aws_internet_gateway.internet_gateway]
}
