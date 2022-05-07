#
# docker https://adamtheautomator.com/docker-ubuntu/
#

sudo apt update -y
sudo apt install docker.io -y
sudo docker run hello-world

#
# k8s prerequisites https://adamtheautomator.com/install-kubernetes-ubuntu/
#

sudo apt update
sudo apt-get install bash-completion
sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt update


sudo apt-get install -y kubeadm kubelet kubectl
kubeadm version && kubelet --version && kubectl version
