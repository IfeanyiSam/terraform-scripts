resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "dev-web" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.dev-pub-1.id
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = [aws_security_group.dev_stack_sg.id]
  tags = {
    Name = "my-dev"
  }
}

resource "aws_ebs_volume" "vol_for_dev-web" {
  availability_zone = var.ZONE1
  size              = 3
  tags = {
    Name = "extra-vol-for-dev-web"
  }
}

resource "aws_volume_attachment" "attach_vol_dev" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.vol_for_dev-web.id
  instance_id = aws_instance.dev-web.id
}

output "PublicIP" {
  value = aws_instance.dev-web.public_ip
}