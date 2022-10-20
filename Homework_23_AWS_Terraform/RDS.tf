resource "aws_db_subnet_group" "subnet-group" {
         name       = "main"
         subnet_ids = [aws_subnet.main_public.id, aws_subnet.main_private.id]

}

resource "aws_db_instance" "rds-instance" {
         allocated_storage       = 20
         db_name                 = "mydb"
         db_subnet_group_name    = aws_db_subnet_group.subnet-group.id
         engine                  = "mysql"
         engine_version          = "5.7"
         instance_class          = "db.t2.micro"
         username                = "admin"
         password                = "anton123"
         parameter_group_name    = "default.mysql5.7"
         port                    = 3306
         publicly_accessible     = false
         storage_type            = "gp2"
         vpc_security_group_ids = [aws_security_group.webserver-security-group.id]
         skip_final_snapshot       = true
         tags = {

    Name = "Example-RDSServer-Instance"
  }
}