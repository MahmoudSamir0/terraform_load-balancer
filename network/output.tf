output "publice_ip_az1" {
  value = aws_subnet.mysub_az1[0].id

}
output "publice_ip_az2" {
  value = aws_subnet.mysub_az2[0].id

}
output "privat_ip_az1" {
  value = aws_subnet.mysub_az1[1].id

}
output "privat_ip_az2" {
  value = aws_subnet.mysub_az2[1].id

}
output "vpc" {
  value = aws_vpc.myvpc.id
}