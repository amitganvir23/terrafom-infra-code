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
// aws kafka  //

resource "aws_launch_configuration" "kafka_lc" {
  name                        = var.kafka_lc
  image_id                    = var.kafka_image
  instance_type               = var.kafka_instance_type
  key_name                    = var.aws_key_name
  security_groups             = ["${aws_security_group.kafka_sg.id}"]
  #user_data                  = "${data.template_file.user_data_kafka.rendered}"
  #user_data                  = "${var.user_data_base64}"
  #user_data                  = "${file("../modules/kafka/kafka_userdata.tpl")}"
  count                       = var.kafka_instance_count
  iam_instance_profile        = aws_iam_instance_profile.kafka_profile.id
  associate_public_ip_address = true
  root_block_device {
  volume_type = "gp2"
  volume_size = 30
  delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = false
  }
  user_data = <<EOF
#!/bin/bash
echo 'Running startup script...'
region="${var.region}"
vpc_id="${var.vpc_id}"
services="${var.kafka_service_name}"
zookeeper_service_name="${var.zookeeper_service_name}"
stackName="${var.environment}"
zone_name="${var.zone_name}"
rec_name="${var.rec_name}"
ec2_tag_key=StackService
ec2_tag_kafka_value="$stackName-$services"
ec2_tag_zookeerp_value="$stackName-$zookeeper_service_name"
baseURL="https://raw.githubusercontent.com/saimantham/terragrunt-infrastructure-live-example/master/scripts"
apt-get update -y
#echo 'Install aws-cli...'
#apt-get install -y awscli ansible
echo 'Downoading raw files from git'
wget -N $baseURL/setup.sh
wget -N $baseURL/UpdateRoute53-yml.sh
wget -N $baseURL/cloudwatch-alarms.sh
wget -N $baseURL/setup-zookeepr.yml
wget -N $baseURL/setup-kafka.yml
chmod +x *.sh
#./setup.sh $region $services $stackName
#./UpdateRoute53-yml.sh $stackName $region $zone_name $rec_name $ec2_tag_key $ec2_tag_kafka_value $vpc_id > route53.log 2>&1
#ansible-playbook -e "REGION=$region ec2_tag_key=$ec2_tag_key ec2_tag_value=$ec2_tag_kafka_value ec2_tag_zookeerp_value=$ec2_tag_zookeerp_value" setup-kafka.yml -vvv > kafka.log 2>&1
EOF
}

resource "aws_autoscaling_group" "kafka_asg" {
  #availability_zones        = ["${var.azs}"]
  name                      = "${var.environment}-kafka-asg"
  max_size                  = var.kafka_cluster_size
  min_size                  = var.kafka_cluster_size
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = var.kafka_cluster_size
  force_delete              = true
  #launch_configuration      = aws_launch_configuration.kafka_lc.id
  launch_configuration    = element(concat(aws_launch_configuration.kafka_lc.*.name, [""]), 0)
  #launch_configuration      = fale ? element(concat(aws_launch_configuration.kafka_lc.*.name, [""]), 0) : var.launch_configuration
  # vpc_zone_identifier       = "${var.aws_pub_subnet_id_str[count.index]}"
  # vpc_zone_identifier       = ["${var.vpc_zone_identifier}"]
  # vpc_zone_identifier       = "${element(var.azs,count.index)}"
  #vpc_zone_identifier       = ["${var.aws_pub_subnet_id_str}"]
  # vpc_zone_identifier      = ["subnet-4c694a2b,subnet-abe80da5"]
  vpc_zone_identifier       = ["${var.vpc_zone_identifier}"]
  lifecycle {
    create_before_destroy = false
  }
  tags = [{
    key                 = "Name"
    value               = "${var.environment}-${var.kafka_service_name}"
    propagate_at_launch = true
  },{
    key                 = "environment"
    value               = var.environment
    propagate_at_launch = true
  },{
    key                 = "Role"
    value               = var.kafka_service_name
    propagate_at_launch = true
  },{
    key                 = "StackService"
    value               = "${var.environment}-${var.kafka_service_name}"
    propagate_at_launch = true
  }]
}


# // aws Autoscaling  //

resource "aws_launch_configuration" "zookeeper_lc" {
  name                 = var.zookeeper_lc
  image_id             = var.zookeeper_image
  instance_type        = var.zookeeper_instance_type
  key_name             = var.aws_key_name
  security_groups      = ["${aws_security_group.kafka_sg.id}"]
  #user_data           = "${data.template_file.user_data_zookeeper.rendered}"
  #user_data            = "${file("zookeeper_userdata.sh")}"
  count                = var.zookeeper_instance_count
  iam_instance_profile = aws_iam_instance_profile.kafka_profile.id
  associate_public_ip_address = true
  root_block_device {
  volume_type = "gp2"
  volume_size = 30
  delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = false
  }
  user_data = <<EOF
#!/bin/bash
echo 'Running startup script...'
region="${var.region}"
vpc_id="${var.vpc_id}"
services="${var.kafka_service_name}"
zookeeper_service_name="${var.zookeeper_service_name}"
stackName="${var.environment}"
zone_name="${var.zone_name}"
rec_name="${var.rec_name}"
ec2_tag_key=StackService
ec2_tag_kafka_value="$stackName-$services"
ec2_tag_zookeerp_value="$stackName-$zookeeper_service_name"
baseURL="https://raw.githubusercontent.com/saimantham/terragrunt-infrastructure-live-example/master/scripts"
#echo 'Install aws-cli...'
#apt-get install -y awscli ansible
apt-get update -y
echo 'Downoading raw files from git'
wget -N $baseURL/setup.sh
wget -N $baseURL/UpdateRoute53-yml.sh
wget -N $baseURL/cloudwatch-alarms.sh
wget -N $baseURL/setup-zookeepr.yml
wget -N $baseURL/setup-kafka.yml
chmod +x *.sh
#./setup.sh $region $services $stackName $zookeeper_service_name
#./UpdateRoute53-yml.sh $stackName $region $zone_name $rec_name $ec2_tag_key $ec2_tag_kafka_value $vpc_id > route53.log 2>&1
#ansible-playbook -e "REGION=$region ec2_tag_key=$ec2_tag_key ec2_tag_value=$ec2_tag_kafka_value" setup-zookeepr.yml -vvv > zookeeper.log 2>&1
EOF
}

resource "aws_autoscaling_group" "zookeeper_asg" {
  #availability_zones       = ["${var.azs}"]
  name                      = "${var.environment}-${var.zookeeper_service_name}-asg"
  max_size                  = var.zookeeper_cluster_size
  min_size                  = var.zookeeper_cluster_size
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = var.zookeeper_cluster_size
  force_delete              = true
  #launch_configuration     = aws_launch_configuration.zookeeper_lc.id
  launch_configuration      = element(concat(aws_launch_configuration.zookeeper_lc.*.name, [""]), 0)
  #vpc_zone_identifier      = ["var.aws_pub_subnet_id_str"]
  vpc_zone_identifier       = ["${var.vpc_zone_identifier}"]
  # vpc_zone_identifier       = "${element(var.azs,count.index)}"
  # vpc_zone_identifier       = ["subnet-4c694a2b,subnet-abe80da5"]
  lifecycle {
    create_before_destroy = false
  }
  tags = [{
    key                 = "Name"
    value               = "${var.environment}-${var.zookeeper_service_name}"
    propagate_at_launch = true
  },{
    key                 = "environment"
    value               = var.environment
    propagate_at_launch = true
  },{
    key                 = "Role"
    value               = var.kafka_service_name
    propagate_at_launch = true
  },{
    key                 = "StackService"
    value               = "${var.environment}-${var.zookeeper_service_name}"
    propagate_at_launch = true
  }]
}

resource "null_resource" "module_dependency_kafka" {
   depends_on = [
        aws_launch_configuration.kafka_lc,
        aws_autoscaling_group.kafka_asg,
        aws_launch_configuration.zookeeper_lc,
        aws_autoscaling_group.zookeeper_asg
   ]
}
