
// VPC DMZ
variable "vpc64dmz" { default = "vpc-0e20c8f58a821963c"}

// PUBLIC SUBNET (FRONTEND)
// AZ 1
variable "publicaz1prddmzfend1s71" { default = "subnet-08efb651ae308017d"}
// AZ 2
variable "publicaz2prddmzfend2s72" { default = "subnet-0d0a7dd65bda9c896"}
// AZ 3
variable "publicaz3prddmzfend3s73" { default = "subnet-040601b3a3cebd352"}

// PRIVATE SUBNET (APP)
// AZ 1
variable "privateaz1appprddmzapp1s67" { default = "subnet-05b6f72c5579a26fb"}
// AZ 2
variable "privateaz2appprddmzapp2s68" { default = "subnet-088db431f0c3bb461"}
// AZ 3
variable "privateaz3appprddmzapp3s69" { default = "subnet-0bd0f8f5f87e89320"}

// VPC INTERNAL
variable "vpc32internal" { default = "vpc-0d91087bed3445ffa"}
// DATABASE SUBNET
// AZ 1
variable "privateaz1dbprddbs1s34" { default = "subnet-02785cd038b417cf2"}
// AZ 2
variable "privateaz2dbprddbs2s35" { default = "subnet-02002d1cfe4adb2dc"}
// AZ 3
variable "privateaz3dbprddbs3s36" { default = "subnet-03210d5b09e5ff558"}

// TAGGING
variable "Name" { default = "" }
variable "sched" { default = "247" }
variable "bgrp" { default = "ffi" }
variable "Backup" { default = "DailyBackup" }
variable "birthday" { default = "20210226" }
variable "Patch" { default = "Windows" }

// KEYS
variable "qns-dta" {
  default = "qns-dta"
}

// GOLDER AMI
data "aws_ssm_parameter" "amazonlinux2" {
    name = "/goldenami/amazonlinux2"
}
data "aws_ssm_parameter" "redhat7" {
    name = "/goldenami/redhat7"
}
data "aws_ssm_parameter" "samba-realmd" {
    name = "/goldenami/redhat7/samba-realmd"
}
data "aws_ssm_parameter" "redhat76" {
    name = "/goldenami/redhat76"
}
data "aws_ssm_parameter" "windows2012r2" {
    name = "/goldenami/windows2012r2"
}
data "aws_ssm_parameter" "windows2012withsqlstandard2014" {
    name = "/goldenami/windows2012withsqlstandard2014"
}
data "aws_ssm_parameter" "windows2016" {
    name = "/goldenami/windows2016"
}
data "aws_ssm_parameter" "windows2016withsqlstandard2016" {
    name = "/goldenami/windows2016withsqlstandard2016"
}
variable "logs" {
    type    = "list"
    default = ["audit", "error", "general", "slowquery"]
}

//SG existing
variable "web" {
  default = "sg-0c414493d34c2d326"
}
variable "ffiterm" {
  default = "sg-079fb77daab12e81b"
}
