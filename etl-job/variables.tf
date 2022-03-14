#my job variables
variable "my_job_script_path" {
  description = "source file path"
  default     = "s3://mygluebucket123/my-job.py"
}
variable "my_job_glue_version" {
  description = "my_job_glue_version"
  default     = "3.0"
}
variable "my_job_number_of_workers" {
  description = "number_of_workers"
  default     = 10
}
variable "my_job_worker_type" {
  description = "worker_type"
  default     = "G.1X"
}



