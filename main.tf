resource local_file my_file{
	filename="automate.txt"
	content="this file is created using terraform"
}

resource aws_s3_bucket my_bucket{
    bucket = "rws-terraform-bucket-on-shot"
}

resource aws_instance my_instance_rk{
	ami="ami-020cba7c55df1f615"
    instance_type="t2.micro"
		
	tags={
		Name="terra_server_rk"
	}
}


