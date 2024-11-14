# resource "aws_instance" "tf_app" {
#   count         = var.number_of_zones
#   ami           = "ami-063d43db0594b521b"
#   instance_type = "t3.micro"
#   subnet_id     = aws_subnet.private_app[count.index].id
#   user_data     = file("user_data.sh")

#   tags = {
#     Name = "Application-${var.availability_zones_names[count.index]}0"
#   }
# }

resource "aws_launch_template" "app_template" {
  name_prefix            = "app-template"
  image_id               = "ami-063d43db0594b521b"
  instance_type          = "t3.micro"
  user_data              = base64encode(file("user_data.sh"))
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "app-template"
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "app_autoscaling_group" {
  count               = var.number_of_zones
  name                = "app-asg-${var.availability_zones_names[count.index]}"
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  target_group_arns   = [aws_lb_target_group.app_tg.arn]
  vpc_zone_identifier = [aws_subnet.private_app[count.index].id]
  depends_on          = [aws_lb_target_group.app_tg, aws_subnet.private_app]

  launch_template {
    id      = aws_launch_template.app_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Application-${var.availability_zones_names[count.index]}${count.index}"
    propagate_at_launch = true
  }
}