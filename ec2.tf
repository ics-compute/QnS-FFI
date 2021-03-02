resource "aws_instance" "qns-dta" {
  ami = "${data.aws_ssm_parameter.amazonlinux2.value}"

  instance_type = "t3.small"
  key_name = var.qns-dta
   subnet_id              = "${var.privateaz2appprddmzapp2s68}"
  security_groups = [
        "${var.web}", "${var.ffiterm}"
  ]
  disable_api_termination = true
  ebs_optimized = false
  hibernation = false

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
    iops = 3000
    encrypted = true
    delete_on_termination = true
}
    ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = 10
    volume_type           = "gp3"
    encrypted             = false
    delete_on_termination = true
    iops = 3000
    }

  tags = {
    Name = "QnS-DTA"
    sched = "${var.sched}"
    bgrp = "${var.bgrp}"
    Backup = "${var.Backup}"
    birthday = "${var.birthday}"
    appenv = "qns-dta"
    "Patch Group" = "Amazon Linux 2"
    cmdbid = "SRDAPP640075"
  }
}