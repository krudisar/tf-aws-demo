output "security_group_name" {
 value = aws_security_group.vra-tf-demo-sg.name
}

output "security_group_id" {
 value = aws_security_group.vra-tf-demo-sg.id
}

output "public_ips" {
    value = aws_instance.ubuntu.*.public_ip
}

output "instances_names" {
    value = aws_instance.ubuntu.*.tags.Name
}
