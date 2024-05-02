# Define the provider
provider "aws" {
  region = "ap-south-1" # Specify your desired AWS region
}

# Create IAM role for Athena
resource "aws_iam_role" "athena_role" {
  name = "athena_role"
  
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "athena:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
})
}



# Create S3 bucket for query results
resource "aws_s3_bucket" "athena_results_bucket" {
  bucket = "athena-query-results-bucket-test-ganesh-np"
  acl    = "private"
}

# Create Athena workgroup
resource "aws_athena_workgroup" "example" {
  name        = "example-workgroup"
  description = "Example Athena Workgroup"
}

# Output Athena configuration
output "athena_configuration" {
  value = {
    "Workgroup"    = aws_athena_workgroup.example.name
    "ResultsBucket" = aws_s3_bucket.athena_results_bucket.bucket
  }
}
