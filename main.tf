provider "aws" {
    region = "us-west-2"
    access_key = ""
    secret_key = ""
}

resource "aws_instance" "gameoflife" {
   ami = "ami-05b598e8868af8430"
   key_name = "Terraform"
   instance_type = "t2.micro"
   vpc_security_group_ids= ["sg-049ae073"]

   connection {
       type = "ssh"
       user = "ubuntu"
       private_key = "${file("Terraform.pem")}"
   }

   provisioner "remote-exec" {
       inline = ["git clone https://github.com/chinnadas/gol-playbook.git","ansible-playbook gol-playbook/gol.yml -i hosts"]
   } 
}