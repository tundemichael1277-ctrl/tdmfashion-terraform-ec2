#!/bin/bash

# get admin privileges
sudo su

# install httpd
yum update -y
yum install -y httpd
systemctl start httpd.service
systemctl enable httpd.service
echo "Welcome to tdmfashion" > /var/www/html/index.html



# 1. Create the new user
USER_NAME="babs"
useradd -m -s /bin/bash "$USER_NAME"

# 2. Add user to the sudoers group (wheel for Amazon Linux/RHEL, sudo for Ubuntu)
usermod -aG wheel "$USER_NAME" || usermod -aG sudo "$USER_NAME"

# 3. Configure passwordless sudo for the user
echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$USER_NAME"
chmod 0440 "/etc/sudoers.d/$USER_NAME"

# 4. Set up the SSH authorized_keys directory and file
USER_HOME="/home/$USER_NAME"
mkdir -p "$USER_HOME/.ssh"
chmod 0700 "$USER_HOME/.ssh"

# 5. Append your SSH public key (Replace the placeholder below)
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAD/qm9tbqgoA2/AiLIuBFm4LJcHwY0I5l3GjthBa/e9 tunde@DESKTOP-BJPC734" > "$USER_HOME/.ssh/authorized_keys"
chmod 0600 "$USER_HOME/.ssh/authorized_keys"

# 6. Correct ownership of the user's home directory files
chown -R "$USER_NAME:$USER_NAME" "$USER_HOME/.ssh"
