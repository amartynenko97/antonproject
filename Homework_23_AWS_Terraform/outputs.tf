output "my-aws-public-subnet-id" {
         value = aws_subnet.main_public.id
}

output "my-aws-private-subnet-id" {
         value = aws_subnet.main_private.id
}

output "my-public-ip-gateway" {
         value = aws_eip.lb.public_ip
}

output "my-allocation-id-natgateway" {
         value = aws_nat_gateway.natgateway.public_ip
}

output "list-objects-route-table-public" {
         value = aws_route_table.public.route
}

output "list-objects-route-table-private" {
         value = aws_route_table.private.route
}


output "ssh_keypair" {
         value = tls_private_key.key.private_key_pem
         sensitive = true
}

output "key_name" {
         value = aws_key_pair.key_pair.key_name
}

output "public_ip_my_instance" {
         value = aws_instance.web_instance.public_ip
}

output "RDS_ENDPOINT" {
         value = aws_db_instance.rds-instance.endpoint

}