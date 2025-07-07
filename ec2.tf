resource aws_key_pair my_key{
    key_name="terra-key-ec2"
    #public_key=file("terra-key-ec2.pub")
    public_key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA7dBql718d6UJFJdm+WiRYxMHw3yi/sE3/8QmluydVi lenovo@DESKTOP-KGS4BES"
}

resource aws_default_vpc default{

}

resource aws_security_group my_security_group{
    name="automate-sg"
    description="this will add and TF generated security group"
    vpc_id=aws_default_vpc.default.id #interpolation is the way to  #extract properties or behavior of resources

    tags={
        Name="automate-sg"
    }

    #inbound rules or ingress rule
    ingress{
        from_port=22
        to_port=22
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
        description="SSH-Open"
    }

    ingress{
        from_port=80
        to_port=80
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
        description="http open"
    }

    ingress{
        from_port=8000
        to_port=8000
        protocol="tcp"
        cidr_blocks=["0.0.0.0/0"]
        description="flask open"
    }

    #outbouns rules or egress rule
     egress{
        from_port=0
        to_port=0
        protocol="-1"
        cidr_blocks=["0.0.0.0/0"] 
        description="all access outbouns"
    }
}


resource "aws_instance" "my_instance"{
    #count=3 #meta argument
    for_each=tomap({
        rws-junnon-automate_micro="t2.micro"
        rws_jonoon_automate_midium="t2.medium"
    })

    depends_on=[aws_security_group.my_security_group]

    key_name=aws_key_pair.my_key.key_name
    security_groups=[aws_security_group.my_security_group.name]
    ami="ami-020cba7c55df1f615"
    instance_type=each.value
    user_data=file("install_nginx.sh")

    root_block_device{
        volume_size=var.env=="prd"?20:var.ec2_root_storage_size
        volume_type="gp3"
    }

    tags={
        Name=each.key
    }
} 

#import manually created instance in terraform
#resource "aws_instance" "my_new_instance"{
#    ami="unknown"
#    instance_type="unknown" 
#}


