terraform {
  backend "gcs" {
    bucket = "41ee0f00c9d852e3-bucket-tfstate"
    prefix = "terraform/state"
  }
}
