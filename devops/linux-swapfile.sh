echo 'this scipt will create 4gb /swapfile'
echo 'ps u need sudo access'
swapon --show
df -h

sudo dd if=/dev/zero of=/swapfile bs=1G count=4
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
swapon --show

echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
