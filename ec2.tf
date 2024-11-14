resource "aws_instance" "tf-app-a1" {
  ami           = "ami-063d43db0594b521b"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.app-private-a.id

  tags = {
    Name = "Aplicação A1"
  }
}

resource "aws_instance" "tf-app-b1" {
  ami           = "ami-063d43db0594b521b"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.app-private-b.id

  tags = {
    Name = "Aplicação B1"
  }
}

resource "aws_instance" "tf-app-c1" {
  ami           = "ami-063d43db0594b521b"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.app-private-c.id

  tags = {
    Name = "Aplicação C1"
  }
}
