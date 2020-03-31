provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "nifi" {
  count = "${var.instance_count["nifi"]}"

   ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.nifi_sg.id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  ebs_optimized           = "${var.ebs_optimized}"
  disable_api_termination = "${var.disable_api_termination}"
  subnet_id              = "${var.subnet_id}"
  user_data                   = "${base64encode(file("${path.module}/mount-nifi.sh"))}"

  tags = {
        Name = "nifi-${var.instance_prefix}-${format("%02d", count.index+1)}"
    }

  root_block_device {
    volume_type           = "${var.root_volume_type}"
    volume_size           = "${var.root_volume_size}"

    }

  ebs_block_device{
      device_name = "/dev/sdb"
      volume_size = 500
      volume_type = "gp2"
    }
  ebs_block_device{
      device_name = "/dev/sdc"
      volume_size = 500
      volume_type = "gp2"
    }
  ebs_block_device{
      device_name = "/dev/sdd"
      volume_size = 500
      volume_type = "gp2"
    }
  ebs_block_device{
      device_name = "/dev/sde"
      volume_size = 50
      volume_type = "gp2"
    }
  ebs_block_device{
      device_name = "/dev/sdf"
      volume_size = 50
      volume_type = "gp2"
    }
  ebs_block_device{
      device_name = "/dev/sdg"
      volume_size = 50
      volume_type = "gp2"
    }
  ebs_block_device{
      device_name = "/dev/sdh"
      volume_size = 50
      volume_type = "gp2"
    }
}

resource "aws_network_interface" "nifi" {
  count = "${var.instance_count["nifi"]}"
  subnet_id       = "${var.secondary_subnet}"
  security_groups = ["${aws_security_group.nifi_sg.id}"]
  attachment {
        instance = "${aws_instance.nifi[count.index].id}"
        device_index = 1
    }
}

resource "aws_instance" "nifi-registry" {
  count = "${var.instance_count["nifi_registry"]}"

   ami                    = "${var.ami}"
  instance_type          = "${var.nifi_registry_instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.nifi_sg.id}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"
  ebs_optimized           = "${var.ebs_optimized}"
  disable_api_termination = "${var.disable_api_termination}"
  subnet_id              = "${var.subnet_id}"
  user_data                   = "${base64encode(file("${path.module}/mount-nifi-registry.sh"))}"

  tags = {
        Name = "nifi-registry-${var.instance_prefix}-${format("%02d", count.index+1)}"
    }

  root_block_device {
    volume_type           = "${var.root_volume_type}"
    volume_size           = "${var.root_volume_size}"

    }

  ebs_block_device{
      device_name = "/dev/sdb"
      volume_size = 50
      volume_type = "gp2"
    }

}

resource "aws_network_interface" "nifi-registry" {
  count = "${var.instance_count["nifi_registry"]}"
  subnet_id       = "${var.secondary_subnet}"
  security_groups = ["${aws_security_group.nifi_sg.id}"]
  attachment {
        instance = "${aws_instance.nifi-registry[count.index].id}"
        device_index = 1
    }
}
