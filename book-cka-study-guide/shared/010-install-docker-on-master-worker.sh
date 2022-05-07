# https://medium.com/@karthikeyan_krishnaswamy/setting-up-a-kubernetes-cluster-on-ubuntu-18-04-4a89c74420f9
sudo apt install curl vim net-tools openssh-server
sudo swapoff -a
sudo sed -i -e 's/\(.*swap.*\)/# \1/' /etc/fstab
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y -qq docker-ce=18.06.1~ce~3-0~ubuntu
sudo apt-mark hold docker-ce
cat << EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
sudo systemctl restart docker
sudo docker version
