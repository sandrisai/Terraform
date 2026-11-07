variable "Vpc-Network" {
  type = object({
    name = string
    cidr_block = string
    public-subnet = object({
      name              = list(string)
      availability_zone = list(string)
      cidr_block        = list(string)

      security_groups-ingress = object({
        from_port  = number
        to_port    = number
        protocol   = string
        cidr_block = list(string)
      })
      security_groups-egress = object({
        from_port  = number
        to_port    = number
        protocol   = string
        cidr_block = list(string)
      })
      route-table = object({
        cidr_block = list(string)
      })
      launch_instance = object({
        name          = list(string)
        ami           = list(string)
        key_name      = string
        instance_type = list(string)
      })
    })
  })
  default = {
    name       = "My-vpc"
    cidr_block = "10.0.0.0/16"
    public-subnet = {
      cidr_block        = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      availability_zone = ["ap-south-1a", "ap-south-1b", "ap-south-1c", "ap-south-1a"]
      name              = ["subnet1", "subnet2", "subnet3", "subnet4"]

    
    security_groups-ingress = {
      from_port  = 22
      to_port    = 22
      protocol   = "tcp"
      cidr_block = ["0.0.0.0/0"]
    }
    security_groups-egress = {
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = ["0.0.0.0/0"]
    }

    
    route-table = {
      cidr_block = ["0.0.0.0/0"]
    }
    launch_instance = {
      ami           = ["ami-0c7632fb77f35db43","ami-0c7632fb77f35db43","ami-0c7632fb77f35db43","ami-0c7632fb77f35db43"]
      instance_type = ["t3.micro","t3.micro","t3.micro","t3.micro"]
      key_name      = "key-pair"
      name          = ["my-instance1", "my-instance2", "my-instance3", "my-instance4"]
    }
  }
  }

}