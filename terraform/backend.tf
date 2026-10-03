terraform {
  backend "s3" {
    bucket = "devops-assignment-terraform-state-nikita-2026"
    key    = "devops-assignment/terraform.tfstate"
    region = "ap-south-1"
  }
}
