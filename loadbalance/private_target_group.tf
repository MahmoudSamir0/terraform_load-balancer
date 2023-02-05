resource "aws_lb_target_group_attachment" "pri_target-att-1" {
  target_group_arn = aws_lb_target_group.pri_target-1.arn
  target_id        = aws_instance.myprivetsub-ec2-1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "pri_target-att-2" {
  target_group_arn = aws_lb_target_group.pri_target-1.arn
  target_id        = aws_instance.myprivetsub-ec2-2.id
  port             = 80
}
resource "aws_lb_target_group" "pri_target-1" {
  name     = "prtarget"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.netw.vpc

}