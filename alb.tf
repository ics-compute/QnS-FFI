//create ALB
resource "aws_lb" "ALBQnS-DTA" {
  name               = "ALBQnS-DTA"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.web}"]
  subnets            = ["${var.publicaz1prddmzfend1s71}", "${var.publicaz2prddmzfend2s72}", "${var.publicaz3prddmzfend3s73}"]

  enable_deletion_protection = false
  /*
  access_logs {
    bucket  = aws_s3_bucket.S3WorkshopAlevz.bucket
    prefix  = "test-lb"
    enabled = true
  }
  */

  tags = {
    Name = "ALBQnS-DTA"
    sched = "${var.sched}"
    bgrp = "${var.bgrp}"
    Backup = "${var.Backup}"
    birthday = "${var.birthday}"
    appenv = "qns-dta"
    "${var.Patch}" = "${var.Patch}"
  }
}

//create TargetGroup
resource "aws_lb_target_group" "ALBTGQnS-DTA" {
  name     = "ALBTGQnS-DTA"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = "${var.vpc64dmz}"
}

//create Listener Http
resource "aws_lb_listener" "ALBListenerALBTGQnS-DTAHTTP" {
  load_balancer_arn = "${aws_lb.ALBQnS-DTA.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ALBTGQnS-DTA.arn}"
  }
}

// Create Listener Https
resource "aws_lb_listener" "ALBListenerALBTGQnS-DTAHTTPS" {
  load_balancer_arn = "${aws_lb.ALBQnS-DTA.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:ap-southeast-1:315897480848:certificate/8ad6fdf5-e813-4ba8-abbc-e31728fd9b1d"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.ALBTGQnS-DTA.arn}"
  }
}

//create attachment to ALB
resource "aws_lb_target_group_attachment" "ALBTGAttachALBTGQnS-DTA" {
  target_group_arn = "${aws_lb_target_group.ALBTGQnS-DTA.arn}"
  target_id        = "${aws_instance.qns-dta.id}"
  port             = 443
}