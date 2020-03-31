
# resource "aws_security_group" "kafka_sg" {
#     name = "prod_kafka"
#     description = "Accept incoming connections."

#     ingress {
#         from_port = 22
#         to_port = 22
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "SSH"
#     }
#     ingress {
#         from_port = 8083
#         to_port = 8083
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Kafka Connect REST API" 
#     }
#     ingress {
#         from_port = 8088
#         to_port = 8088
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "KSQL Server REST API" 
#     }
#     ingress {
#         from_port = 8082
#         to_port = 8082
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "REST Proxy" 
#     }
#     ingress {
#         from_port = 8081
#         to_port = 8081
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Schema Registry REST API" 
#     }
#     ingress {
#         from_port = 1099
#         to_port = 1099
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "JMX" 
#     }
#     ingress {
#         from_port = 2181
#         to_port = 2181
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "ZooKeeper" 
#     }
#     ingress {
#         from_port = 2888
#         to_port = 2888
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "ZooKeeper" 
#     }
#     ingress {
#         from_port = 3888
#         to_port = 3888
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "ZooKeeper" 
#     }
#     ingress {
#       from_port = 9093
#       to_port = 9093
#       protocol = "tcp"
#       cidr_blocks = [
#         "10.0.0.0/8"]
#       description = "Kafka Brokers"
#     }
#     ingress {
#         from_port = 9092
#         to_port = 9092
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Kafka Brokers"
#     }
#     ingress {
#         from_port = 9091
#         to_port = 9091
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Kafka Brokers"
#     }
#     ingress {
#         from_port = 9021
#         to_port = 9021
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Control Center"
#     }
#     ingress {
#         from_port = 980
#         to_port = 980
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Elastic Search"
#     }
#     ingress {
#         from_port = 8080
#         to_port = 8080
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Nifi"
#     }
#     ingress {
#         from_port = 9997
#         to_port = 9997
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Nifi"
#     }
#     ingress {
#         from_port = 9696
#         to_port = 9696
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Nifi"
#     }
#     ingress {
#         from_port = 9999
#         to_port = 9999
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Nifi"
#     }
#     ingress {
#         from_port = 18080
#         to_port = 18080
#         protocol = "tcp"
#         cidr_blocks = ["10.0.0.0/8"]
#         description = "Nifi Registry"
#     }

#     egress {
#         from_port   = 0
#         to_port     = 0
#         protocol    = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     vpc_id = "${var.vpc_id}"

#     tags = {
#         Name = "kafka_cluster_sg"
#     }
# }

