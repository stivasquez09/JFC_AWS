resource "aws_security_group" "alb_sg" {
  name        = "${var.nombre}-alb-sg"
  description = "Allow HTTP from internet"
  vpc_id      = var.my_vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.nombre}-alb-sg"
  }
}

resource "aws_lb" "alb" {
  name               = "${var.nombre}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.my_subnets
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Name = "${var.nombre}-alb"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.nombre}-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.my_vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.nombre}-tg"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
