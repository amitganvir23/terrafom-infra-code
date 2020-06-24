data "aws_vpc" "vpc_data" {
  id = var.vpc_id
}
resource "aws_security_group" "elasticsearch_sg" {
    name    = "${var.elasticsearch_service_name}-${var.environment}-sg"
    vpc_id  = var.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks =  ["0.0.0.0/0"]
        description = "SSH Temprory allow Remove this after SG created"
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "SSH"
    }

    ingress {
        from_port   = 9200
        to_port     = 9200
        protocol    = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "elasticsearch Connect REST API" 
    }
    ingress {
        from_port   = 9300
        to_port     = 9300
        protocol    = "tcp"
        cidr_blocks =  ["${data.aws_vpc.vpc_data.cidr_block}"]
        description = "KSQL Server REST API" 
    }
    ingress {
        from_port   = 0
        to_port     = 65535
        protocol    = "udp"
        self        = true
    }
    ingress {
        from_port   = 0
        to_port     = 65535
        protocol    = "udp"
        cidr_blocks = ["${data.aws_vpc.vpc_data.cidr_block}"]
    }
    ingress {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["${data.aws_vpc.vpc_data.cidr_block}"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}
