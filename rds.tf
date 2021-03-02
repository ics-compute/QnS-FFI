resource "aws_db_subnet_group" "dbSubnetqns-dta" {
  name       = "dbsubnetgroupqnsdta"
  subnet_ids = ["${var.privateaz1dbprddbs1s34}", "${var.privateaz2dbprddbs2s35}", "${var.privateaz3dbprddbs3s36}"]

  tags = {
    Name = "dbsubnetgroupqnsdta"
    sched = "${var.sched}"
    bgrp = "${var.bgrp}"
    birthday = "${var.birthday}"
    appenv = "rds-qns-dta"
  }
}

resource "aws_security_group" "qnsdta-rds-sg" {
    name = "qnsdta-rds-sg"
    description = "qnsdta-rds-sg"
    vpc_id      = "${var.vpc32internal}"

     ingress {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["10.230.64.0/19", "10.230.32.0/19"]
    }

}
// RDS 1
resource "aws_db_instance" "qns-dta-rds" {
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0.21"
  instance_class          = "db.t3.small"
  name                    = "qnsdta"
  identifier              = "qnsdta"
  username                = "admin"
  password                = "gPGkT9QRu4WDTP8q"
  port                    = "3306"
  vpc_security_group_ids  = ["${aws_security_group.qnsdta-rds-sg.id}"]
  db_subnet_group_name    = "${aws_db_subnet_group.dbSubnetqns-dta.name}"
  deletion_protection     = true
  backup_retention_period = 30
  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  ca_cert_identifier      = "rds-ca-2019"
  availability_zone       = "ap-southeast-1b"


  skip_final_snapshot = true
  publicly_accessible = false

  tags = {
    Name = "qns-dta-rds"
    sched = "${var.sched}"
    bgrp = "${var.bgrp}"
    birthday = "${var.birthday}"
    appenv = "RDS-qns-dta"
  }
}
