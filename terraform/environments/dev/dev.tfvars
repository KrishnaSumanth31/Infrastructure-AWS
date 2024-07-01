# Bucket Variables

bucket_name_artifact = "artifact-bucket-infra-check"
bucket_name_raw = "raw-bucket-infra-check"
region = "ap-south-1"

#RDS Aurora Cluster Variables

environment  = "Dev"
cluster_id   = "dev-cluster"

username = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEA7uWmCpW3c6F8E7h9...\n...+3bBSsG2Gie4XlXjYdUQIDAQABAoIBAQC...\nmytestpassword..lmhgs"
password = "May@2024"
port = "5032"
description = "Access to Postgres DB secrets"
tags         = {
  Environment = "Develop"
  Application = "MyAppWorking"
}
