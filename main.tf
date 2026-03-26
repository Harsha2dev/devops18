resource "aws_launch_template" "web_server_as" {
    name = "newproject1"
    image_id           = "ami-02dfbd4ff395f2a1b"
    vpc_security_group_ids = [aws_security_group.web_server.id]
    instance_type = "t3.micro"
    key_name = "one"
    tags = {
        Name = "DevOps"
    }
    
}
   


  resource "aws_elb" "web_server_22b"{
     name = "web-server-22b"
     security_groups = [aws_security_group.web_server.id]
     subnets = ["subnet-0706851e90035f4a9", "subnet-0a00fc9448adf0c42"]
     listener {
      instance_port     = 8000
      instance_protocol = "http"
      lb_port           = 80
      lb_protocol       = "http"
    }
    tags = {
      Name = "terraform-elb"
    }
  }
resource "aws_autoscaling_group" "web_server_asg_devops1" {
    name                 = "web-server-asg_devops1"
    min_size             = 1
    max_size             = 3
    desired_capacity     = 2
    health_check_type    = "EC2"
    load_balancers       = [aws_elb.web_server_22b.name]
    availability_zones    = ["us-east-1a", "us-east-1b"] 
    launch_template {
        id      = aws_launch_template.web_server_as.id
        version = "$Latest"
      }
    
    
  }

