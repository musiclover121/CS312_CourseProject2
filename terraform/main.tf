resource "aws_security_group" "minecraft_sg" {
  name = "minecraft-server-sg"

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "minecraft" {
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]

  tags = {
    Name = "MinecraftServer"
  }

  provisioner "file" {
    source      = "setup.sh"
    destination = "/tmp/setup.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/delphi/MyLinuxKey.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/setup.sh",
      "sudo /tmp/setup.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/delphi/MyLinuxKey.pem")
      host        = self.public_ip
    }
  }
}
