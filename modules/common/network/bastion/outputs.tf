output "private_ip" {
  value = "${join(",", aws_instance.bastion.*.private_ip)}"
}

output "bastion_ssh_id" {
  value = "${module.bastion_ssh.sg_id}"
}

output "allow_bastion_id" {
  value = "${module.allow_bastion.sg_id}"
}
