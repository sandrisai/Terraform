output "vpc" {
  value = aws_vpc.my-vpc.id

}
output "subnet" {
  value = aws_subnet.my-subnet.id

}
output "subnet0" {
  value = aws_subnet.my-subnet1.id

}
output "internet" {
  value = aws_internet_gateway.IG.id

}
output "security" {
  value = aws_security_group.SG.id

}
output "instance" {
  value = aws_instance.my-instance.id

}
output "instance0" {
  value = aws_instance.my-instance1.id

}
output "ip" {
  value = aws_instance.my-instance.public_ip

}
output "ip1" {
  value = aws_instance.my-instance1.public_ip
}