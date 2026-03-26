#Application load balancer security group------------------------------------------

resource "aws_security_group" "alb_sg" {
    name = "alb_sg"
    vpc_id = var.vpc_id

    ingress {
        description = "Allow HTTP from internet"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Outbound route"
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

#Elastic Cloud computer security group---------------------------------------------

resource "aws_security_group" "ec2-sg" {
    name = "ec2-sg"
    vpc_id = var.vpc_id
}

#Adding the rules seperately for EC2 security group--------------------------------

resource "aws_security_group_rule" "ec2_http_from_alb" {
    type = ingress
    from_port = 80
    to_port = 80
    protocol = "tcp"

    security_group_id = aws_security_group.ec2-sg.id
    source_security_group_id = aws_security_group.alb_sg.id
  
}


resource "aws_security_group_rule" "ec2_ssh" {
    type = "ingress"

    from_port = 22
    to_port = 22
    protocol = "tcp"

    security_group_id = aws_security_group.ec2-sg.id
    cidr_blocks = [var.allowed_ssh_ip]
  
}


resource "aws_security_group_rule" "ec2-egress" {
    type = "egress"

    from_port = 0
    to_port = 0
    protocol = -1

    security_group_id = aws_security_group.ec2-sg.id
    cidr_blocks = ["0.0.0.0/0"]
  
}