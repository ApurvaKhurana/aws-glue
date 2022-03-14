#compute environment variables
variable "source_endpoint" {
  description = "source file path"
  default     = "s3://mygluebucket123/glue-job-sample.csv"
}