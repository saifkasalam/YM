
#Creating SG for ALB
resource "aws_security_group" "sgalb" {
    name = "sgalb"
    description = "sgalb"
    vpc_id      = aws_vpc.VPC01.id
    tags = {
      "Name" = "SG-ALB"

    }
  
   dynamic "ingress" {
    iterator = port
    for_each = var.ingressalb 
       content {
        from_port = port.value
        to_port = port.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
   }
     dynamic "egress" {
     iterator = port 
     for_each = var.egressalb
     content {
        from_port = port.value
        to_port = port.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
 }
}

#Creating ALB

resource "aws_alb" "YMALB" {
    name = "YMALB"
    subnets = ["${aws_subnet.subnet01.id}","${aws_subnet.subnet02.id}"]
    security_groups = [aws_security_group.sgalb.id]
    tags = {
    Name = "YMALB"
    }
}

#Creating Target Group

resource "aws_alb_target_group" "targetgroup01" {
    name = "targetgroup01"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.VPC01.id
}

# Attaching Instances to Target Group

resource "aws_alb_target_group_attachment" "Backend-attach01" {
    target_group_arn = aws_alb_target_group.targetgroup01.arn
    target_id = aws_instance.ec2-01.id
    port = 80
  
}

resource "aws_alb_target_group_attachment" "Backend-attach02" {
    target_group_arn = aws_alb_target_group.targetgroup01.arn
    target_id = aws_instance.ec2-02.id
    port = 80
}

resource "aws_alb_target_group_attachment" "Backend-attach03" {
    target_group_arn = aws_alb_target_group.targetgroup01.arn
    target_id = aws_instance.ec2-03.id
    port = 80
}


# Specify Listener

resource "aws_alb_listener" "Backen-Listener01" {
    load_balancer_arn = aws_alb.YMALB.id
    port = 80

 default_action {
    target_group_arn = aws_alb_target_group.targetgroup01.id
    type = "forward"   
 }   
  
}