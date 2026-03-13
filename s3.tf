terraform {
backend "s3" {
region = "us-east-2"
bucket = "sahajaranjani.flm.monobucket2"
key = "prod/terraform.tfstate"
}
}





