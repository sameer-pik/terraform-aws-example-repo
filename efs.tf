# Create the EFS filesystem
resource "aws_efs_file_system" "test-efs" {
  creation_token   = "test-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  lifecycle_policy {
    transition_to_ia = "AFTER_90_DAYS"
  }
  tags {
    Name          = "${var.service_name}-test-efs"
    ProductDomain = "${var.product_domain}"
    Service       = "${var.service_name}"
    Team          = "${var.team}"
    Cluster       = "${var.service_name}-${var.role}"
    Application   = "${var.role}"
    Environment   = "${var.environment}"
    Description   = "${var.service_name} - <description of the efs here>"
    ManagedBy     = "terraform"
  }
 }

#Module to be imported for security group naming convention(this block is applicable only the module to be imported)
module "sg_name_efs" {
  source        = "github.com/<organization>/terraform-aws-resource-naming?ref=v0.17.0"
  name_prefix   = "${local.service_name}-efs"
  resource_type = "security_group"
}

# EFS Security group
resource "aws_security_group" "test_efs_sg" {
  name        = "${module.sg_name_efs.name}"
  description = "Security group for EFS connectivity"
  vpc_id      = "${local.vpc_id}"
  tags {
    Name          = "${module.sg_name_efs.name}"
    Service       = "${var.service_name}"
    Team          = "${var.team}"
    ProductDomain = "${var.product_domain}"
    Environment   = "${var.environment}"
    Description   = "Security group for EFS connectivity"
    ManagedBy     = "terraform"
  }
}

# EFS requires a mount target, which gives VMs a way to mount the EFS volume using NFS
resource "aws_efs_mount_target" "efs_mount" {
  file_system_id  = "${aws_efs_file_system.test-efs.id}"
  subnet_id       = "${local.subnet_db}"
  security_groups = ["${aws_security_group.test_efs_sg.id}"]
}
