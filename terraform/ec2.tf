resource "aws_instance" "main_ec2" {
  ami                    = "ami-08e3b3155fc937a94"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  key_name               = "devops-assignment-key-new"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "${var.project_name}-ec2"
  }
}
