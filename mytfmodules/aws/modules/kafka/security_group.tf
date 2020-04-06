
data "aws_vpc" "vpc_data" {
  id = var.vpc_id
}
resource "aws_security_group" "kafka_sg" {
    name = "${var.broker_service_name}-${var.environment}-sg"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
        description = "SSH Temprory allow Remove this after SG created"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "SSH"
    }

    ingress {
        from_port = 8083
        to_port = 8083
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Kafka Connect REST API" 
    }
    ingress {
        from_port = 8088
        to_port = 8088
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "KSQL Server REST API" 
    }
    ingress {
        from_port = 8082
        to_port = 8082
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "REST Proxy" 
    }
    ingress {
        from_port = 8081
        to_port = 8081
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Schema Registry REST API" 
    }
    ingress {
        from_port = 1099
        to_port = 1099
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "JMX" 
    }
    ingress {
        from_port = 2181
        to_port = 2181
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "ZooKeeper" 
    }
    ingress {
        from_port = 2888
        to_port = 2888
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "ZooKeeper" 
    }
    ingress {
        from_port = 3888
        to_port = 3888
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "ZooKeeper" 
    }
    ingress {
      from_port = 9093
      to_port = 9093
      protocol = "tcp"
      cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
      description = "Kafka Brokers"
    }
    ingress {
        from_port = 9092
        to_port = 9092
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Kafka Brokers"
    }
    ingress {
        from_port = 9091
        to_port = 9091
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Kafka Brokers"
    }
    ingress {
        from_port = 9021
        to_port = 9021
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Control Center"
    }
    ingress {
        from_port = 980
        to_port = 980
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Elastic Search"
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Nifi"
    }
    ingress {
        from_port = 9997
        to_port = 9997
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Nifi"
    }
    ingress {
        from_port = 9696
        to_port = 9696
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Nifi"
    }
    ingress {
        from_port = 9999
        to_port = 9999
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Nifi"
    }
    ingress {
        from_port = 18080
        to_port = 18080
        protocol = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "Nifi Registry"
    }
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "udp"
        self = true
    }
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "udp"
        cidr_blocks = ["${data.aws_vpc.vpc_data.cidr_block}"]
    }
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["${data.aws_vpc.vpc_data.cidr_block}"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}
