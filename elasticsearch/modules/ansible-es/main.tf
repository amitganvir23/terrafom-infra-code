resource "null_resource" "call_ansible" {
provisioner "local-exec" {
      command = "${path.module}/ansible.sh"
      interpreter = ["sh"]
      environment = {
        elasticsearch_ec2_tag = "${var.elasticsearch_ec2_tag}"
      }
  }
}
