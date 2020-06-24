resource "aws_instance" "elasticsearch" {
  count                       = var.elasticsearch_instance_count
  ami                         = var.aws_image
  instance_type               = var.aws_instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = ["${aws_security_group.elasticsearch_sg.id}"]
  associate_public_ip_address = var.associate_public_ip_address
  # ebs_optimized             = "${var.ebs_optimized}"
  # disable_api_termination   = "${var.disable_api_termination}"
  subnet_id                   = var.subnet_id[count.index]
  user_data                   = base64encode(file("${path.module}/script.sh"))
  root_block_device {
                      volume_type = var.root_volume_type
                      volume_size = var.elasticsearch_root_volume_size
                      delete_on_termination = true
	}
  volume_tags =      {
		                  Name = "${var.elasticsearch_service_name}-${var.environment}-volume-${format("%02d", count.index+1)}" 
		                }
  tags        =     {
                      Name        = "${var.elasticsearch_service_name}-${var.environment}-${format("%02d", count.index+1)}" 
                      environment = var.environment
                      Role        = var.elasticsearch_service_name
  }
  ebs_block_device {
                    device_name = "/dev/sdb"
                    volume_type = var.elasticsearch_ebs_volume_type
                    volume_size = var.elasticsearch_ebs_volume_size
                   }
}


# resource "null_resource" "aws_ansible_call" {
# provisioner "local-exec" {
#       command = "${path.module}/ansible.sh"
#       interpreter = ["sh"]
#   }
# }

