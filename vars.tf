
variable "AWS_REGION"{
    default = "us-east-2"
}
variable "AMI" {
    default = "ami-0960ab670c8bb45f3"
  }
variable "Instancetype"{
    default = "t2.micro"
}

# Variables for SG-Ports
variable "ingressbackend" {
    type = list(number)
    default = [ 80,443,22 ]
  
}
variable "egressbackend" {
    type = list(number)
    default = [ 80,443,25,3306,53,8080 ]
  
}

variable "ingressalb" {
    type = list(number)
    default = [ 80,443,22 ]
  
}
variable "egressalb" {
    type = list(number)
    default = [ 80,443,22 ]
  
}

