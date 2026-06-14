resource "aws_instance" "tdmfashion_app" {
    ami = "ami-011c04cb040289c2a"
    instance_type = "t3.micro"
    key_name = "double"
    security_groups = [ aws_security_group.tdmfashion_sg.name ]
    tags = {
      Name = "tdmfashion-app"
    }
  
}