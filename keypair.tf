#Creating Key pair in aws
  resource "tls_private_key" "rsa01" {
    algorithm = "RSA"
    rsa_bits  = 4096
  }

#Adding Public Key to AWS
  resource "aws_key_pair" "ym_key" {
    key_name = "ym_key"
    public_key = tls_private_key.rsa01.public_key_openssh  
  }
#Donloading private key to local system
  resource "local_file" "ym_key" {
    content  = tls_private_key.rsa01.private_key_pem
    filename = "ym_key"
  }