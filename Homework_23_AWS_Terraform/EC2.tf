resource "tls_private_key" "key" {
         algorithm = "RSA"
         rsa_bits  = 4096
}         

resource "local_sensitive_file" "private_key" {
         filename          = pathexpand("/root/testterraform/mykey.pem")
         content = tls_private_key.key.private_key_pem
         file_permission   = "0400"
         directory_permission = "700"
}

resource "aws_key_pair" "key_pair" {
         key_name   = "Mykeys"
         public_key = tls_private_key.key.public_key_openssh
}

resource "aws_security_group" "webserver-security-group" {
         name             = "allow_ssh"
         description      = "Allow ssh inbound traffic"
         vpc_id           = aws_vpc.main.id
         depends_on       = [aws_vpc.main]

     ingress {
         from_port        = 22
         to_port          = 22
         protocol         = "tcp"
         description      = "Telnet"
         cidr_blocks      = ["0.0.0.0/0"]
    }
    
     ingress {
         from_port        = 80
         to_port          = 80
         protocol         = "tcp"
         description      = "HTTP"
         cidr_blocks      = ["0.0.0.0/0"]
    }

     ingress {
         from_port        = 443
         to_port          = 443
         protocol         = "tcp"
         description      = "HTTPS"
         cidr_blocks      = ["0.0.0.0/0"]
    }
    
     ingress {
         from_port        = 3306
         to_port          = 3306
         protocol         = "tcp"
         description      = "MySQL"
         cidr_blocks      = ["0.0.0.0/0"]
    }

     egress {
         from_port        = 0
         to_port          = 0
         protocol         = "-1"
         cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_instance" {
         ami                         = var.instance_ami
         instance_type               = var.instance_type
         key_name                    = "Mykeys"
         security_groups             = [aws_security_group.webserver-security-group.id]
         subnet_id                   = aws_subnet.main_public.id
         associate_public_ip_address = true
         user_data = <<-EOF
             #!/bin/bash 

             sudo yum -y install httpd php mysql php-mysql

             case $(ps -p 1 -o comm | tail -1) in
             systemd) sudo systemctl enable --now httpd ;;
             init) sudo chkconfig httpd on; sudo service httpd start ;;
             *) echo "Error starting httpd (OS not using init or systemd)." 2>&1
             esac

             if [ ! -f /var/www/html/bootcamp-app.tar.gz ]; then
             cd /var/www/html
             sudo wget https://s3.amazonaws.com/immersionday-labs/bootcamp-app.tar
             tar xvf bootcamp-app.tar
             sudo chown apache:root /var/www/html/rds.conf.php
             fi
             sudo yum -y update
         EOF

    lifecycle {
         create_before_destroy = true
  }
    tags = {

    Name = "EC2-configuration"
  }
     

provisioner "file" {
         source      = "/root/testterraform/mykey.pem"
         destination = "/home/ec2-user/mykey.pem"

connection {
         type        = "ssh"
         user        = "ec2-user"
         private_key = tls_private_key.key.private_key_pem
         host        = aws_instance.web_instance.public_ip
    }
}

provisioner "remote-exec" {
         inline = ["chmod 400 ~/mykey.pem"]
connection {
         type        = "ssh"
         user        = "ec2-user"
         private_key = tls_private_key.key.private_key_pem
         host        = aws_instance.web_instance.public_ip
    }
} 

}