resource "aws_lb" "pub_load" {
  name            = "puload"
  internal        = false
  security_groups = [module.mysecurity.my_public_elb_sg_id]
  subnets         = [module.netw.publice_ip_az1,module.netw.publice_ip_az2]
}

resource "aws_lb_listener" "pub_listener" {
  load_balancer_arn = aws_lb.pub_load.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pub_target-1.arn
  }
}

