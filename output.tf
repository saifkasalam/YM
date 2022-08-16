
output "PrivateIP-backen-01" {
       value = aws_instance.ec2-01.private_ip
    }

    
output "PrivateIP-backen-02" {
       value = aws_instance.ec2-02.private_ip
    }
    
output "PrivateIP-backen-03" {
       value = aws_instance.ec2-03.private_ip
    }

output "PublicIP-Jump-Server" {
   value = aws_instance.ec2-04.public_ip
  
}

output "ALB-DnsName" {
   value = aws_alb.YMALB.dns_name
      
    }
