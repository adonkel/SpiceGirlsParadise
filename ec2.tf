resource "aws_instance" "main" {
  ami                    = data.aws_ssm_parameter.instance_ami.value
  instance_type          = "t3.micro"
  key_name               = "SpiceGirlsParadise"
  subnet_id              = aws_subnet.Public[0].id
  vpc_security_group_ids = [aws_vpc.main.default_security_group_id]
  tags = {
    "Name" = "${var.default_tags.env}-EC2"
  }
   #This is to force metadata v2, which mitigates role credential leakage in the event of a SSRF
	#metadata_options {
		#http_tokens = "enabled"
	#}
  user_data = base64encode(file("C:/Users/adonk/OneDrive/Desktop/Terraform/user.sh"))
}
output "ec2_ssh_command" {
  value = "ssh -i SpiceGirlsParadise.pem ubuntu@ec2-${replace(aws_instance.main.public_ip, ".", "-")}.compute-1.amazonaws.com"
}