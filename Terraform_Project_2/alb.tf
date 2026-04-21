resource "aws_alb" "prod_alb" {
  name            = "prod-alb"
  security_groups = []
  subnets         = []
  tags = {
    Name = "prod-alb"
  }
}

resource "aws_alb_target_group" "alb_tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"

  health_check {
    path                = "/"
    port                = 80
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
  }
}

resource "aws_alb_listener" "alb_listner" {
  load_balancer_arn = aws_alb.prod_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.alb_tg.arn
    type             = "forward"
  }
}
