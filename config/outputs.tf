output "webserver_public_ip_address" {
  value       = aws_eip.my_static_ip.public_ip
  description = "My Web Server public IP"
}

output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}

output "data_aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}
