resource "aws_db_subnet_group" "appmesh-rds-subnet" {
  name       = "appmesh-rds-subnet"
  subnet_ids = [aws_subnet.appmesh-subnet-1.id, aws_subnet.appmesh-subnet-2.id]

  tags = {
    Name = "AppMesh RDS DB subnet group"
  }
}

resource "aws_db_instance" "uc-blue-kong" {
  identifier           = "uc-blue-kong-database"
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "13.4"
  instance_class       = "db.t3.micro"
  name                 = "kong"
  username             = "kong"
  password             = random_password.uc-blue-password.result
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.appmesh-rds-subnet.name
  publicly_accessible  = true
  vpc_security_group_ids = [ aws_security_group.appmesh-allow-all.id ]
}

resource "aws_db_instance" "uc-green-kong" {
  identifier           = "uc-blue-green-database"
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "13.4"
  instance_class       = "db.t3.micro"
  name                 = "kong"
  username             = "kong"
  password             = random_password.uc-green-password.result
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.appmesh-rds-subnet.name
  publicly_accessible  = true
  vpc_security_group_ids = [ aws_security_group.appmesh-allow-all.id ]
}
