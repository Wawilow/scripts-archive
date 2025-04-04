#!/bin/bash

# Define the username
USERNAME="cicd"

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo or log in as root."
    exit 1
fi

# Prompt for the new user's password
echo "Enter password for user '$USERNAME':"
read -s PASSWORD

# Create the user with a home directory and bash shell
useradd -m -s /bin/bash "$USERNAME"

# Set the password for the new user
echo "$USERNAME:$PASSWORD" | chpasswd

# Add the user to the 'sudo' group
usermod -aG sudo "$USERNAME"


# Grant passwordless sudo privileges by creating a sudoers file
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > "/etc/sudoers.d/$USERNAME"

# Set the correct permissions for the sudoers file
chmod 0440 "/etc/sudoers.d/$USERNAME"

echo "User '$USERNAME' has been created and configured for passwordless sudo access."

sudo -u "$USERNAME" mkdir -p /home/"$USERNAME"/.ssh
sudo chmod 700 /home/"$USERNAME"/.ssh
sudo chown -R "$USERNAME":"$USERNAME" /home/"$USERNAME"/.ssh

echo "Created .ssh"
