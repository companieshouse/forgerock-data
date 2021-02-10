resource "aws_s3_bucket" "b" {
  bucket = "amido-ch-test-bucket"
  acl    = "private"

  tags = {
    Name        = "Amido CH Test Bucket"
    Environment = "Dev"
  }
}

# module "ecs" {
#   source = "./modules/ecs"
#   depends_on = [module.monitoring]
#   vpc_id = module.network.vpc_id
#   ecr_url = module.ecr.url
#   private_subnets = module.network.private_subnets
# }

# module "monitoring" {
#   source = "./modules/monitoring"

# }
