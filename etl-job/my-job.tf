resource "aws_glue_job" "my_first_glue_job" {
  name     = "my-first--glue-job"

  role_arn = data.aws_iam_role.my_glue_service_role.arn
  glue_version = var.my_job_glue_version
  number_of_workers = var.my_job_number_of_workers
  worker_type = var.my_job_worker_type

  command {
    script_location = var.my_job_script_path
  }
}

resource "aws_glue_job" "my_streaming_glue_job" {
  name     = "my-streaming-glue-job"
  
  role_arn = data.aws_iam_role.my_glue_service_role.arn
  glue_version = var.my_job_glue_version
  number_of_workers = var.my_job_number_of_workers
  worker_type = var.my_job_worker_type

  command {
    name            = "gluestreaming"
    script_location = var.my_job_script_path
  }
}