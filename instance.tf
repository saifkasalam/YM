
# Creating EC2 Instances

    resource "aws_instance" "ec2-01" {
     ami           = var.AMI
     instance_type = "t2.micro"
     subnet_id     = aws_subnet.subnet03.id
     key_name      = "ym_key"
     vpc_security_group_ids = [aws_security_group.webtraffic.id]
     tags = {
          Name = "EC2-A-1"   }
    }
    
    resource "aws_instance" "ec2-02" {
       ami           = var.AMI
       instance_type = "t2.micro"
       subnet_id     = aws_subnet.subnet03.id
       key_name      = "ym_key"
       vpc_security_group_ids = [aws_security_group.webtraffic.id]
          tags = {
           Name = "EC2-A-2"   }
    }
    
     resource "aws_instance" "ec2-03" {
       ami           = var.AMI
       instance_type = "t2.micro"
       subnet_id     = aws_subnet.subnet04.id
       vpc_security_group_ids = [aws_security_group.webtraffic.id]
       key_name      = "ym_key"
          tags = {
           Name = "EC2-B-1"   }
     }

      resource "aws_instance" "ec2-04" {
       ami           = var.AMI
       instance_type = "t2.micro"
       subnet_id     = aws_subnet.subnet01.id
       vpc_security_group_ids = [aws_security_group.sgalb.id]
       key_name      = "ym_key"
          tags = {
           Name = "Jump Server"   }
     }