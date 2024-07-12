resource "aws_subnet" "subnets_public" {
  for_each = var.vpc_info.cidr_blocks_public

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(
    {
      Name = "${var.common_info.env}-${each.value.subnet_name}"
    }
  )
}

resource "aws_subnet" "subnets_private" {
  for_each = var.vpc_info.cidr_blocks_private

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(
    {
      Name = "${var.common_info.env}-${each.value.subnet_name}"
    }
  )
}

resource "aws_subnet" "subnets_private_db" {
  for_each = var.vpc_info.cidr_blocks_private_db

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(
    {
      Name = "${var.common_info.env}-${each.value.subnet_name}"
    }
  )
}
