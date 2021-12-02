# The RDS Database


resource "aws_db_instance" "RDS-Project-5" {
  allocated_storage    = 12
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "Project5"
  password             = "Password1"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}