resource "aws_lb" "alb" {

  name               = "my-alb"
  load_balancer_type = "application"

  subnets         = var.subnet_ids
  security_groups = [var.security_group_id]

  tags = {
    Name = "my-alb"
  }
}


resource "aws_lb_target_group" "tg" {

  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "tg_attach" {

  count = length(var.target_instance_ids)

  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.target_instance_ids[count.index]
  port             = 80
}

resource "aws_lb_listener" "listener" {

  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

