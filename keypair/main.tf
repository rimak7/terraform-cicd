# 1. Generate a secure private key
resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Create the AWS Key Pair using the public key part
resource "aws_key_pair" "deployer_key" {
  key_name   = var.keyname
  public_key = tls_private_key.rsa_key.public_key_openssh
}

# 3. (Optional) Save the private key to your local machine
resource "local_file" "private_key_pem" {
  content  = tls_private_key.rsa_key.private_key_pem
  filename = "${aws_key_pair.deployer_key.key_name}.pem"

  # Ensure permissions are restricted (crucial for SSH)
  #   directory_permission = "0700"
  file_permission = "0400"
}