provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 0.9, <= 0.12.24"
  required_providers {
    aws = {
      version = ">= 2.7.0, < 2.55.0"
    }
  }
}

resource "aws_instance" "kafka_broker" {
  count                       = var.kafka_instance_count
  ami                         = var.kafka_image
  instance_type               = var.kafka_instance_type
  key_name                    = var.aws_key_name
  # vpc_security_group_ids      = ["${aws_security_group.kafka_sg.id}"]
  vpc_security_group_ids      = ["sg-003cdfcb5197ad1aa"]
  associate_public_ip_address = var.associate_public_ip_address
  # ebs_optimized           = "${var.ebs_optimized}"
  # disable_api_termination = "${var.disable_api_termination}"
  subnet_id                   = var.subnet_id
  user_data                   = base64encode(file("${path.module}/mount.sh"))
  root_block_device {
                      volume_type = var.root_volume_type
                      volume_size = var.root_volume_size
                      delete_on_termination = true
	                  }
  volume_tags =      {
		                  Name = "${var.broker_service_name}-${var.environment}-volume-${format("%02d", count.index+1)}" 
		                }
  tags        =     {
                      Name = "${var.broker_service_name}-${var.environment}-${format("%02d", count.index+1)}" 
                      environment = var.environment
                   }
  ebs_block_device{
      device_name = "/dev/sdb"
      volume_size = 8
      # volume_type = "st1"
      volume_type = "gp2"
    }
}

resource "aws_network_interface" "kafka_broker" {
  # count = "${var.instance_count["broker"]}"
  count = var.kafka_instance_count
  # count = 2
  subnet_id       = var.subnet_id
  # security_groups = ["${aws_security_group.kafka_sg.id}"]
  security_groups = ["sg-003cdfcb5197ad1aa"]
  attachment {
        instance = aws_instance.kafka_broker[count.index].id
        device_index = 1
    }
}


// =========== zookeeper ============= //

resource "aws_instance" "zookeeper" {
  count                       = var.zookeeper_instance_count
  ami                         = var.kafka_image
  instance_type               = var.kafka_instance_type
  key_name                    = var.aws_key_name
  # vpc_security_group_ids      = ["${aws_security_group.kafka_sg.id}"]
  vpc_security_group_ids      = ["sg-003cdfcb5197ad1aa"]
  associate_public_ip_address = var.associate_public_ip_address
  # ebs_optimized           = "${var.ebs_optimized}"
  # disable_api_termination = "${var.disable_api_termination}"
  subnet_id                   = var.subnet_id
  user_data                   = base64encode(file("${path.module}/mount.sh"))
  root_block_device {
                      volume_type = var.root_volume_type
                      volume_size = var.root_volume_size
                      delete_on_termination = true
	                  }
  volume_tags =      {
		                  Name = "${var.zookeeper_service_name}-${var.environment}-volume-${format("%02d", count.index+1)}" 
		                }
  tags        =     {
                      Name = "${var.zookeeper_service_name}-${var.environment}-${format("%02d", count.index+1)}" 
                      environment = var.environment
                   }
  ebs_block_device{
      device_name = "/dev/sdb"
      volume_size = 8
      # volume_type = "st1"
      volume_type = "gp2"
    }
}

resource "aws_network_interface" "zookeeper" {
  # count = "${var.instance_count["broker"]}"
  count = var.zookeeper_instance_count
  # count = 2
  subnet_id       = var.subnet_id
  # security_groups = ["${aws_security_group.kafka_sg.id}"]
  security_groups = ["sg-003cdfcb5197ad1aa"]
  attachment {
        instance = aws_instance.zookeeper[count.index].id
        device_index = 1
    }
}


# resource "null_resource" "jenkins-ansible-master-call" {
# provisioner "local-exec" {
#       command = "sleep 3m && ansible-playbook ${path.module}/../ansible-kafka/playbooks/kafka.yml --private-key=/root/terra-private-key -i ${path.module}/../ansible-kafka/hosts/ec2.py -e master_hostname=tag_Name_Jenkins_Master"

#   }
# }




# resource "aws_network_interface" "kafka-broker" {
#   count = "${var.instance_count["broker"]}"
#   subnet_id       = "${var.secondary_subnet}"
#   security_groups = ["${aws_security_group.kafka_sg.id}"]
#   attachment {
#         instance = "${aws_instance.kafka-broker[count.index].id}"
#         device_index = 1
#     }
# }

# resource "aws_instance" "zookeeper" {
#   count = "${var.instance_count["zookeeper"]}"

#    ami                    = "${var.ami}"
#   instance_type          = "${var.instance_type}"
#   key_name               = "${var.key_name}"
#   vpc_security_group_ids = ["${aws_security_group.kafka_sg.id}"]
#   associate_public_ip_address = "${var.associate_public_ip_address}"
#   ebs_optimized           = "${var.ebs_optimized}"
#   disable_api_termination = "${var.disable_api_termination}"
#   subnet_id              = "${var.subnet_id}"
#   user_data                   = "${base64encode(file("${path.module}/mount.sh"))}"

#   tags = {
#         Name = "kafka-zookeeper-${var.instance_prefix}-${format("%02d", count.index+1)}"
#     }

#   root_block_device {
#     volume_type           = "${var.root_volume_type}"
#     volume_size           = "${var.root_volume_size}"

#     }

#   ebs_block_device{
#       device_name = "/dev/sdb"
#       volume_size = 100
#       volume_type = "gp2"
#     }

# }

# resource "aws_network_interface" "zookeeper" {
#   count = "${var.instance_count["zookeeper"]}"
#   subnet_id       = "${var.secondary_subnet}"
#   security_groups = ["${aws_security_group.kafka_sg.id}"]
#   attachment {
#         instance = "${aws_instance.zookeeper[count.index].id}"
#         device_index = 1
#     }
# }

# resource "aws_instance" "kafka-schema-registry" {
#   count = "${var.instance_count["schema"]}"

#    ami                    = "${var.ami}"
#   instance_type          = "${var.instance_type}"
#   key_name               = "${var.key_name}"
#   vpc_security_group_ids = ["${aws_security_group.kafka_sg.id}"]
#   associate_public_ip_address = "${var.associate_public_ip_address}"
#   ebs_optimized           = "${var.ebs_optimized}"
#   disable_api_termination = "${var.disable_api_termination}"
#   subnet_id              = "${var.subnet_id}"
#   user_data                   = "${base64encode(file("${path.module}/mount.sh"))}"

#   tags = {
#         Name = "kafka-schema-${var.instance_prefix}-${format("%02d", count.index+1)}"
#     }

#   root_block_device {
#     volume_type           = "${var.root_volume_type}"
#     volume_size           = "${var.root_volume_size}"

#     }

#   ebs_block_device{
#       device_name = "/dev/sdb"
#       volume_size = 200
#       volume_type = "gp2"
#     }

# }

# resource "aws_network_interface" "kafka-schema-registry" {
#   count = "${var.instance_count["schema"]}"
#   subnet_id       = "${var.secondary_subnet}"
#   security_groups = ["${aws_security_group.kafka_sg.id}"]
#   attachment {
#         instance = "${aws_instance.kafka-schema-registry[count.index].id}"
#         device_index = 1
#     }
# }



# resource "aws_instance" "kafka-connect" {
#   count = "${var.instance_count["connect"]}"

#    ami                    = "${var.ami}"
#   instance_type          = "${var.instance_type}"
#   key_name               = "${var.key_name}"
#   vpc_security_group_ids = ["${aws_security_group.kafka_sg.id}"]
#   associate_public_ip_address = "${var.associate_public_ip_address}"
#   ebs_optimized           = "${var.ebs_optimized}"
#   disable_api_termination = "${var.disable_api_termination}"
#   subnet_id              = "${var.subnet_id}"
#   user_data                   = "${base64encode(file("${path.module}/mount.sh"))}"

#   tags = {
#         Name = "kafka-connect-${var.instance_prefix}-${format("%02d", count.index+1)}"
#     }

#   root_block_device {
#     volume_type           = "${var.root_volume_type}"
#     volume_size           = "${var.root_volume_size}"

#     }

#   ebs_block_device{
#       device_name = "/dev/sdb"
#       volume_size = 200
#       volume_type = "gp2"
#     }

# }

# resource "aws_network_interface" "kafka-connect" {
#   count = "${var.instance_count["connect"]}"
#   subnet_id       = "${var.secondary_subnet}"
#   security_groups = ["${aws_security_group.kafka_sg.id}"]
#   attachment {
#         instance = "${aws_instance.kafka-connect[count.index].id}"
#         device_index = 1
#     }
# }

# resource "aws_instance" "kafka-ksql" {
#   count = "${var.instance_count["ksql"]}"

#   ami                    = "${var.ami}"
#   instance_type          = "${var.instance_type}"
#   key_name               = "${var.key_name}"
#   vpc_security_group_ids = ["${aws_security_group.kafka_sg.id}"]
#   associate_public_ip_address = "${var.associate_public_ip_address}"
#   ebs_optimized           = "${var.ebs_optimized}"
#   disable_api_termination = "${var.disable_api_termination}"
#   subnet_id              = "${var.subnet_id}"
#   user_data                   = "${base64encode(file("${path.module}/mount.sh"))}"

#   tags = {
#         Name = "kafka-ksql-${var.instance_prefix}-${format("%02d", count.index+1)}"
#     }

#   root_block_device {
#     volume_type           = "${var.root_volume_type}"
#     volume_size           = "${var.root_volume_size}"

#     }

#   ebs_block_device{
#       device_name = "/dev/sdb"
#       volume_size = 200
#       volume_type = "gp2"
#     }

# }

# resource "aws_network_interface" "kafka-ksql" {
#   count = "${var.instance_count["ksql"]}"
#   subnet_id       = "${var.secondary_subnet}"
#   security_groups = ["${aws_security_group.kafka_sg.id}"]
#   attachment {
#         instance = "${aws_instance.kafka-ksql[count.index].id}"
#         device_index = 1
#     }
# }

# resource "aws_instance" "kafka-restproxy" {
#   count = "${var.instance_count["rest"]}"

#    ami                    = "${var.ami}"
#   instance_type          = "${var.instance_type}"
#   key_name               = "${var.key_name}"
#   vpc_security_group_ids = ["${aws_security_group.kafka_sg.id}"]
#   associate_public_ip_address = "${var.associate_public_ip_address}"
#   ebs_optimized           = "${var.ebs_optimized}"
#   disable_api_termination = "${var.disable_api_termination}"
#   subnet_id              = "${var.subnet_id}"
#   user_data                   = "${base64encode(file("${path.module}/mount.sh"))}"

#   tags = {
#         Name = "kafka-restproxy-${var.instance_prefix}-${format("%02d", count.index+1)}"
#     }

#   root_block_device {
#     volume_type           = "${var.root_volume_type}"
#     volume_size           = "${var.root_volume_size}"

#     }

#   ebs_block_device{
#       device_name = "/dev/sdb"
#       volume_size = 200
#       volume_type = "gp2"
#     }

# }


# resource "aws_network_interface" "kafka-restproxy" {
#   count = "${var.instance_count["rest"]}"
#   subnet_id       = "${var.secondary_subnet}"
#   security_groups = ["${aws_security_group.kafka_sg.id}"]
#   attachment {
#         instance = "${aws_instance.kafka-restproxy[count.index].id}"
#         device_index = 1
#     }
# }
# resource "aws_instance" "control-center" {
#   count = "${var.instance_count["control_center"]}"

#    ami                    = "${var.ami}"
#   instance_type          = "${var.instance_type}"
#   key_name               = "${var.key_name}"
#   vpc_security_group_ids = ["${aws_security_group.kafka_sg.id}"]
#   associate_public_ip_address = "${var.associate_public_ip_address}"
#   ebs_optimized           = "${var.ebs_optimized}"
#   disable_api_termination = "${var.disable_api_termination}"
#   subnet_id              = "${var.subnet_id}"
#   user_data                   = "${base64encode(file("${path.module}/mount.sh"))}"

#   tags = {
#         Name = "kafka-control-center-${var.instance_prefix}-${format("%02d", count.index+1)}"
#     }

#   root_block_device {
#     volume_type           = "${var.root_volume_type}"
#     volume_size           = "${var.root_volume_size}"

#     }

#   ebs_block_device{
#       device_name = "/dev/sdb"
#       volume_size = 200
#       volume_type = "gp2"
#     }

# }

# resource "aws_network_interface" "control-center" {
#   count = "${var.instance_count["control_center"]}"
#   subnet_id       = "${var.secondary_subnet}"
#   security_groups = ["${aws_security_group.kafka_sg.id}"]
#   attachment {
#         instance = "${aws_instance.control-center[count.index].id}"
#         device_index = 1
#     }
# }
