resource "aws_launch_template" "lt" {

  name_prefix = "my-launch-template"

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.security_group_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "Hello from AutoScaling $(hostname)" > /var/www/html/index.html
              EOF
  )
}

resource "aws_autoscaling_group" "asg" {

  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]

  health_check_type = "EC2"
}

  target_group_arns = [var.target_group_arn]

  health_check_type = "EC2"

  tag {
    key                 = "Name"
    value               = "AutoScaling-EC2"
    propagate_at_launch = true
  }
}