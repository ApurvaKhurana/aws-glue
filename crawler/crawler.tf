# glue service iam role
resource "aws_iam_role" "my_glue_service_role" {
  name = "my-glue-service-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
        "Service": "glue.amazonaws.com"
        }
    }
    ]
}
EOF
}

#glue role policy document to allow read from s3
data "aws_iam_policy_document" "read_from_source_s3" {
  statement {
    sid = "AllowSourceS3Read"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    effect    = "Allow"
    resources = ["arn:aws:s3:::mygluebucket123/*"]
  }
}

#glue role policy document to allow read from s3
resource "aws_iam_policy" "read_from_source_s3_policy" {
  name        = "read-from-source-s3-policy"
  description = "read-from-source-s3-policyy"
  policy      = data.aws_iam_policy_document.read_from_source_s3.json
}

#attach read_from_source_s3_policy
resource "aws_iam_role_policy_attachment" "read_from_source_s3_policy" {
  role       = aws_iam_role.my_glue_service_role.name
  policy_arn = aws_iam_policy.read_from_source_s3_policy.arn
}

#attach glue service role policy
resource "aws_iam_role_policy_attachment" "glue_service_role_policy" {
  role       = aws_iam_role.my_glue_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

# aws glue catalog database
resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "my-glue-catalog-database"
}

# glue crawler
resource "aws_glue_crawler" "my_glue_crawler" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  name          = "my-glue-crawler"
  role          = aws_iam_role.my_glue_service_role.arn

  s3_target {
    path = var.source_endpoint
  }
}