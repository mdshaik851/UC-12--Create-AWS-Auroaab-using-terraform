variables {
  vpc_cidr = "10.0.0.0/16"  
}

run "verify_vpc_cidr_range" {
  command = plan

  # Assert that the vpc cidr matches what we specified
  assert {
    condition     = module.vpc.vpc_cidr == var.vpc_cidr
    error_message = "VPC cidr range mismatch"
  }
}