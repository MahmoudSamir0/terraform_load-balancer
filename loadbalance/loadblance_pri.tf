resource "aws_lb" "pri_load" {
  name            = "prload"
  internal        = true
  security_groups = [module.mysecurity.my_private_elb_sg_id]
  subnets         = [module.netw.privat_ip_az1,module.netw.privat_ip_az2]
}
resource "aws_lb_listener" "pri_listener" {
  load_balancer_arn = aws_lb.pri_load.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pri_target-1.arn
  }
}

