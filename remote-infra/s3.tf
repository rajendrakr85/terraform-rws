resource "aws_s3_bucket" "my_tf_s3_bucket"{
    bucket="rws-junoon-state-bucket"

    tags={
        Name="rws-junoon-state-bucket"
    }
}