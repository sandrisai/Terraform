output "vpc" {
  value = aws_vpc.VPC.id
  
}
output "public-subnet" {
  value = aws_subnet.My-subnet[*].id
  
}
output "security_groups_id" {
  value = aws_security_group.SG.id
  
}
output "internet" {
  value = aws_internet_gateway.IGW.id
  
}
output "route_table_id" {
  value = aws_route_table.Route.id
  
}
output "instance_id" {
  value = aws_instance.instance[*].id
  
}
output "instance_public_ip"{
  value = aws_instance.instance[*].public_ip
}