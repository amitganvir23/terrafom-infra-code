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
  count                       = var.broker_instance_count
  ami                         = var.kafka_image
  instance_type               = var.kafka_instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = ["${aws_security_group.kafka_sg.id}"]
  associate_public_ip_address = var.associate_public_ip_address
  # ebs_optimized           = "${var.ebs_optimized}"
  # disable_api_termination = "${var.disable_api_termination}"
  subnet_id                   = var.subnet_id
  user_data                   = base64encode(file("${path.module}/mount.sh"))
  root_block_device {
                      volume_type = var.root_volume_type
                      volume_size = var.broker_root_volume_size
                      delete_on_termination = true
	}
  volume_tags =      {
		                  Name = "${var.broker_service_name}-${var.environment}-volume-${format("%02d", count.index+1)}" 
		                }
  tags        =     {
                      Name        = "${var.broker_service_name}-${var.environment}-${format("%02d", count.index+1)}" 
                      environment = var.environment
                      Role        = var.broker_service_name
  }
  ebs_block_device {
                    device_name = "/dev/sdb"
                    volume_type = var.broker_ebs_volume_type
                    volume_size = var.broker_ebs_volume_size
                   }
}

resource "aws_network_interface" "kafka_broker" {
  count = var.broker_instance_count
  subnet_id       = var.subnet_id
  security_groups = ["${aws_security_group.kafka_sg.id}"]
  attachment {
            instance = aws_instance.kafka_broker[count.index].id
            device_index = 1
  }
  tags = {
          Name = "${var.broker_service_name}-${var.environment}-${format("%02d", count.index+1)}"
  }
}


// =========== zookeeper ============= //

resource "aws_instance" "zookeeper" {
  count                       = var.zookeeper_instance_count
  ami                         = var.kafka_image
  instance_type               = var.kafka_instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = ["${aws_security_group.kafka_sg.id}"]
  associate_public_ip_address = var.associate_public_ip_address
  subnet_id                   = var.subnet_id
  user_data                   = base64encode(file("${path.module}/mount.sh"))
  root_block_device {
                      volume_type = var.root_volume_type
                      volume_size = var.zookeeper_root_volume_size
                      delete_on_termination = true
	}
  volume_tags =      {
		                  Name = "${var.zookeeper_service_name}-${var.environment}-volume-${format("%02d", count.index+1)}" 
	}
  tags        =     {
                      Name        = "${var.zookeeper_service_name}-${var.environment}-${format("%02d", count.index+1)}" 
                      environment = var.environment
                      Role        = var.zookeeper_service_name
  }
  ebs_block_device {
                    device_name = "/dev/sdb"
                    volume_type = var.zookeeper_ebs_volume_type
                    volume_size = var.zookeeper_ebs_volume_size
                   }
}

resource "aws_network_interface" "zookeeper" {
  # count = "${var.instance_count["broker"]}"
  count = var.zookeeper_instance_count
  subnet_id       = var.subnet_id
  security_groups = ["${aws_security_group.kafka_sg.id}"]
  attachment {
        instance = aws_instance.zookeeper[count.index].id
        device_index = 1
    }
  tags = {
          Name = "${var.zookeeper_service_name}-${var.environment}-${format("%02d", count.index+1)}"
  }
}


//========= Kafka Schema Registry =========//

resource "aws_instance" "kafka_schema_registry" {
  count                       = var.kafka_schema_registry_instance_count
  ami                         = var.kafka_image
  instance_type               = var.kafka_instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = ["${aws_security_group.kafka_sg.id}"]
  associate_public_ip_address = var.associate_public_ip_address
  # ebs_optimized             = "${var.ebs_optimized}"
  # disable_api_termination   = "${var.disable_api_termination}"
  subnet_id                   = var.subnet_id
  user_data                   = base64encode(file("${path.module}/mount.sh"))
  root_block_device {
                      volume_type = var.root_volume_type
                      volume_size = var.kafka_schema_registry_root_volume_size
                      delete_on_termination = true
	                  }
  volume_tags =     {
		                  Name = "${var.kafka_schema_registry_name}-${var.environment}-volume-${format("%02d", count.index+1)}" 
		                }
  tags        =     {
                      Name        = "${var.kafka_schema_registry_name}-${var.environment}-${format("%02d", count.index+1)}" 
                      environment = var.environment
                      Role        = var.kafka_schema_registry_name
                   }
  ebs_block_device {
                    device_name = "/dev/sdb"
                    volume_type = var.kafka_schema_registry_ebs_volume_type
                    volume_size = var.kafka_schema_registry_ebs_volume_size
                  }
}

resource "aws_network_interface" "kafka_schema_registry" {
  # count = "${var.instance_count["broker"]}"
  count           = var.kafka_schema_registry_instance_count
  subnet_id       = var.subnet_id
  security_groups = ["${aws_security_group.kafka_sg.id}"]
  attachment {
                instance = aws_instance.kafka_schema_registry[count.index].id
                device_index = 1
             }
  tags = {
           Name = "${var.kafka_schema_registry_name}-${var.environment}-${format("%02d", count.index+1)}"
         }
}

//========= kafka connect =========//

resource "aws_instance" "kafka_connect" {
  count                       = var.kafka_connect_instance_count
  ami                         = var.kafka_image
  instance_type               = var.kafka_instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = ["${aws_security_group.kafka_sg.id}"]
  associate_public_ip_address = var.associate_public_ip_address
  # ebs_optimized             = "${var.ebs_optimized}"
  # disable_api_termination   = "${var.disable_api_termination}"
  subnet_id                   = var.subnet_id
  user_data                   = base64encode(file("${path.module}/mount.sh"))
  root_block_device {
                      volume_type = var.root_volume_type
                      volume_size = var.kafka_connect_root_volume_size
                      delete_on_termination = true
	                  }
  volume_tags =     {
		                  Name = "${var.kafka_connect_name}-${var.environment}-volume-${format("%02d", count.index+1)}" 
		                }
  tags        =     {
                      Name        = "${var.kafka_connect_name}-${var.environment}-${format("%02d", count.index+1)}" 
                      environment = var.environment
                      Role        = var.kafka_connect_name
                    }
  ebs_block_device {
                    device_name = "/dev/sdb"
                    volume_type = var.kafka_connect_ebs_volume_type
                    volume_size = var.kafka_connect_ebs_volume_size
                   }
}

resource "aws_network_interface" "kafka_connect" {
  count = var.kafka_connect_instance_count
  subnet_id       = var.subnet_id
  security_groups = ["${aws_security_group.kafka_sg.id}"]
  attachment {
              instance = aws_instance.kafka_connect[count.index].id
              device_index = 1
             }
  tags = {
           Name = "${var.kafka_connect_name}-${var.environment}-${format("%02d", count.index+1)}"
         }
}


//========= kafka ksql =========//

resource "aws_instance" "kafka_ksql" {
  count                       = var.kafka_ksql_instance_count
  ami                         = var.kafka_image
  instance_type               = var.kafka_instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = ["${aws_security_group.kafka_sg.id}"]
  associate_public_ip_address = var.associate_public_ip_address
  # ebs_optimized             = "${var.ebs_optimized}"
  # disable_api_termination   = "${var.disable_api_termination}"
  subnet_id                   = var.subnet_id
  user_data                   = base64encode(file("${path.module}/mount.sh"))
  root_block_device {
                      volume_type           = var.root_volume_type
                      volume_size           = var.kafka_ksql_root_volume_size
                      delete_on_termination = true
	                  }
  volume_tags =     {
		                  Name = "${var.kafka_ksql_name}-${var.environment}-volume-${format("%02d", count.index+1)}" 
		                }
  tags        =     {
                      Name        = "${var.kafka_ksql_name}-${var.environment}-${format("%02d", count.index+1)}" 
                      environment = var.environment
                      Role        = var.kafka_ksql_name
                    }
  ebs_block_device {
                    device_name = "/dev/sdb"
                    volume_type = var.kafka_ksql_ebs_volume_type
                    volume_size = var.kafka_ksql_ebs_volume_size
                   }
}

resource "aws_network_interface" "kafka_ksql" {
  count           = var.kafka_ksql_instance_count
  subnet_id       = var.subnet_id
  security_groups = ["${aws_security_group.kafka_sg.id}"]
  attachment {
              instance = aws_instance.kafka_ksql[count.index].id
              device_index = 1
             }
  tags = {
           Name = "${var.kafka_ksql_name}-${var.environment}-${format("%02d", count.index+1)}"
         }
}

//========= kafka restproxy =========//

resource "aws_instance" "kafka_restproxy" {
  count                       = var.kafka_restproxy_instance_count
  ami                         = var.kafka_image
  instance_type               = var.kafka_instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = ["${aws_security_group.kafka_sg.id}"]
  associate_public_ip_address = var.associate_public_ip_address
  # ebs_optimized             = "${var.ebs_optimized}"
  # disable_api_termination   = "${var.disable_api_termination}"
  subnet_id                   = var.subnet_id
  user_data                   = base64encode(file("${path.module}/mount.sh"))
  root_block_device {
                      volume_type = var.root_volume_type
                      volume_size = var.kafka_restproxy_root_volume_size
                      delete_on_termination = true
	                  }
  volume_tags =     {
		                  Name = "${var.kafka_restproxy_name}-${var.environment}-volume-${format("%02d", count.index+1)}" 
		                }
  tags        =     {
                      Name        = "${var.kafka_restproxy_name}-${var.environment}-${format("%02d", count.index+1)}" 
                      environment = var.environment
                      Role        = var.kafka_restproxy_name
                    }
  ebs_block_device {
                    device_name = "/dev/sdb"
                    volume_type = var.kafka_restproxy_ebs_volume_type
                    volume_size = var.kafka_restproxy_ebs_volume_size
                   }
}

resource "aws_network_interface" "kafka_restproxy" {
  count           = var.kafka_restproxy_instance_count
  subnet_id       = var.subnet_id
  security_groups = ["${aws_security_group.kafka_sg.id}"]
  attachment {
                instance = aws_instance.kafka_restproxy[count.index].id
                device_index = 1
             }
  tags = {
           Name = "${var.kafka_restproxy_name}-${var.environment}-${format("%02d", count.index+1)}"
         }
}

//========= kafka control center =========//
resource "aws_instance" "kafka_control_center" {
  count                       = var.kafka_control_center_instance_count
  ami                         = var.kafka_image
  instance_type               = var.kafka_instance_type
  key_name                    = var.aws_key_name
  vpc_security_group_ids      = ["${aws_security_group.kafka_sg.id}"]
  associate_public_ip_address = var.associate_public_ip_address
  # ebs_optimized             = "${var.ebs_optimized}"
  # disable_api_termination   = "${var.disable_api_termination}"
  subnet_id                   = var.subnet_id
  user_data                   = base64encode(file("${path.module}/mount.sh"))
  root_block_device {
                      volume_type = var.root_volume_type
                      volume_size = var.kafka_control_center_root_volume_size
                      delete_on_termination = true
	                  }
  volume_tags =     {
		                  Name = "${var.kafka_control_center_name}-${var.environment}-volume-${format("%02d", count.index+1)}" 
		                }
  tags        =     {
                      Name        = "${var.kafka_control_center_name}-${var.environment}-${format("%02d", count.index+1)}" 
                      environment = var.environment
                      Role        = var.kafka_control_center_name
                    }
  ebs_block_device {
                    device_name = "/dev/sdb"
                    volume_type = var.kafka_control_center_ebs_volume_type
                    volume_size = var.kafka_control_center_ebs_volume_size
                   }
}

resource "aws_network_interface" "kafka_control_center" {
  count           = var.kafka_control_center_instance_count
  subnet_id       = var.subnet_id
  security_groups = ["${aws_security_group.kafka_sg.id}"]
  attachment {
                instance = aws_instance.kafka_control_center[count.index].id
                device_index = 1
             }
  tags = {
           Name = "${var.kafka_control_center_name}-${var.environment}-${format("%02d", count.index+1)}"
         }
}


resource "null_resource" "kafka_ansible_call" {
provisioner "local-exec" {
      command = "${path.module}/ansible.sh"
      interpreter = ["sh"]
  }
}

