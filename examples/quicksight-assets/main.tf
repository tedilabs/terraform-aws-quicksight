provider "aws" {
  region = "us-east-1"
}


###################################################
# QuickSight Folders
###################################################

module "folder__dev" {
  source = "../../modules/folder"
  # source  = "tedilabs/quicksight/aws//modules/folder"
  # version = "~> 0.5.0"

  name          = "dev"
  display_name  = "Dev Folder"
  parent_folder = null

  permissions = []

  assets = {
    analyses   = []
    dashboards = []
    datasets   = []
  }

  tags = {
    "project" = "terraform-aws-quicksight-examples"
  }
}

module "folder__test" {
  source = "../../modules/folder"
  # source  = "tedilabs/quicksight/aws//modules/folder"
  # version = "~> 0.5.0"

  name          = "test"
  display_name  = "Test Folder"
  parent_folder = null

  permissions = []

  assets = {
    analyses   = []
    dashboards = []
    datasets   = []
  }

  tags = {
    "project" = "terraform-aws-quicksight-examples"
  }
}
