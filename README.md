# terrafom-infra-code

## how to execute complete elasticsearch stack
Varify/update your required value before execute terraform and ansible
 - terrafom-infra-code/elasticsearch/stack-deployment/terraform.tfvars
 - terrafom-infra-code/ansible-code/elasticsearch/group_vars/all.yml


## It will create infrastructer and execute ansible plybook to configure elasticsearch
```sh
$ cd terrafom-infra-code/elasticsearch/stack-deployment
$ terraform init
$ terraform plan
$ terraform apply
```

## To execute ansible plybook manualy
```sh
$ cd terrafom-infra-code/ansible-code/elasticsearch
$ ansible-playbook -i hosts/ec2.py elasticsearch.yml -e "elasticsearch_ec2_tag=tag_Role_elasticsearch"
```

