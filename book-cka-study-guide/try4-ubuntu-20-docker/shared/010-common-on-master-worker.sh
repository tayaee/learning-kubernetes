# https://containerjournal.com/features/setting-up-kubernetes-in-an-on-premises-environment/

#
# docker
#

sudo apt-get update
sudo apt-get install curl
curl -fsSL get.docker.com | sudo sh get-docker.sh
sudo docker ps
sudo docker run hello-world
docker version

#
# kubernetes
#
sudo apt-get install bash-completion
sudo apt-get install vim -y
sudo apt-get update
# sudo vi /etc/hosts
# 192.168.1.69 kube-master
# 192.168.1.70 kube-worker-1
# 192.168.1.71 kube-worker-2
sudo swapoff -a
sudo sed -i -e 's/^\(.*swap.*\)/# \1/' /etc/fstab
sudo apt-get update && sudo apt-get install -y apt-transport-https
sudo snap install kubelet --classic
sudo snap install kubectl --classic
sudo snap install kubeadm --classic
