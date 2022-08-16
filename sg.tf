
#Creating Security Group for Backend 

resource "aws_security_group" "webtraffic" {
    name = "SG-Backend"
    description = "SG-Backend"
    vpc_id      = aws_vpc.VPC01.id
    tags = {
      "Name" = "SG-Backend"

    }
  
   dynamic "ingress" {
    iterator = port
    for_each = var.ingressbackend   
     content {
        from_port = port.value
        to_port = port.value
        protocol = "tcp"
        cidr_blocks = ["192.168.0.0/16"]
    }
   }
     dynamic "egress" {
     iterator = port 
     for_each = var.egressbackend
     content {
        from_port = port.value
        to_port = port.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
 }
}



