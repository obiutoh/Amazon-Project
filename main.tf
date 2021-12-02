# The VPC 

resource "aws_vpc" "VPC_Main" {
  cidr_block = "10.0.0.0/16"
}


# The Public Subnet-1

resource "aws_subnet" "Pub-subnet1" {
  vpc_id     = aws_vpc.VPC_Main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Pub-subnet1"
  }
}


# The Public Subnet-2

resource "aws_subnet" "Pub-subnet2" {
  vpc_id     = aws_vpc.VPC_Main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Pub-subnet2"
  }
}


# The Pri-Subnet1

resource "aws_subnet" "Pri-subnet1" {
  vpc_id     = aws_vpc.VPC_Main.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Pri-subnet1"
  }
}


# The Pri-Subnet2

resource "aws_subnet" "Pri-subnet2" {
  vpc_id     = aws_vpc.VPC_Main.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Pri-subnet2"
  }
}

# The Route Table Public

resource "aws_route_table" "Public-Routetabl" {
  vpc_id = aws_vpc.VPC_Main.id



  tags = {
    Name = "Public-Routetabl"
  }
}


# The Route Table Private

resource "aws_route_table" "Private-Routetabl" {
  vpc_id = aws_vpc.VPC_Main.id



  tags = {
    Name = "Private-Routetabl"
  }
}


# The Public subnet Association with Route1

resource "aws_route_table_association" "Public-Subnetasso1" {
  subnet_id      = aws_subnet.Pub-subnet1.id
  route_table_id = aws_route_table.Public-Routetabl.id
}


# The Public subnet Association with Route2

resource "aws_route_table_association" "Public-Subnetasso2" {
  subnet_id      = aws_subnet.Pub-subnet1.id
  route_table_id = aws_route_table.Public-Routetabl.id
}



# The Private  subnet Association with Route1

resource "aws_route_table_association" "Private-Subnetasso1" {
  subnet_id      = aws_subnet.Pri-subnet1.id
  route_table_id = aws_route_table.Private-Routetabl.id
}

# The Private  subnet Association with Route2

resource "aws_route_table_association" "Private-Subnetasso2" {
  subnet_id      = aws_subnet.Pri-subnet2.id
  route_table_id = aws_route_table.Private-Routetabl.id
}



# The Internet Gateway 


resource "aws_internet_gateway" "GW2-Internet1" {
  vpc_id = aws_vpc.VPC_Main.id

  tags = {
    Name = "GW2-Internet1"
  }
}


# Conection of Route to Internet GW And Pub-Route


resource "aws_route" "Public-igw" {
  route_table_id            = aws_route_table.Public-Routetabl.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.GW2-Internet1.id               
} 





# Allocate Elastic IP Address (EIP1)


resource "aws_eip" "eip-for-natgw" {
  vpc        = true
  depends_on = [aws_internet_gateway.GW2-Internet1]

  tags       = {
    Name     = "eip-for-natgw"
  }
}


# NAT GATEWAY

resource "aws_nat_gateway" "natgw-project5" {
  allocation_id = aws_eip.eip-for-natgw.id
  subnet_id     = aws_subnet.Pub-subnet1.id

  tags = {
    Name = "natgw-project5"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.GW2-Internet1]
}