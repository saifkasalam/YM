resource "aws_db_instance" "Database1" {
    db_name = "mydb"
    identifier = "identifier-ymdb"
    instance_class = "db.t2.micro"
    engine = "mysql"
    engine_version = "8.0.28"
    username = "admin"
    password = "12345678"
    port = 3306
    allocated_storage = 20
    skip_final_snapshot = true
    db_subnet_group_name = aws_db_subnet_group.ymdbsubnet.id
         
}

resource "aws_db_subnet_group" "ymdbsubnet" {
    name = "ymdb-subnet"
    subnet_ids = [aws_subnet.subnet05.id, aws_subnet.subnet06.id]
    tags = {
      "Name" = "YMDB-Subnetgroup"
    }
  
}