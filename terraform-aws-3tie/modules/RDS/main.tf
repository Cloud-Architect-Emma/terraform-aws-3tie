resource "aws_db_instance" "main" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  db_name              = "mydb"
  username             = "admin"
  password             = var.db_password  # Store securely (e.g., AWS Secrets Manager)
  vpc_security_group_ids = [var.sg_id]
  db_subnet_group_name = aws_db_subnet_group.main.name
}
