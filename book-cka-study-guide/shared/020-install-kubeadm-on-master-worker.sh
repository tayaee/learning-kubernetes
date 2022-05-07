# https://medium.com/@karthikeyan_krishnaswamy/setting-up-a-kubernetes-cluster-on-ubuntu-18-04-4a89c74420f9
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
#sudo apt-get install -y kubelet=1.21.2-00 kubeadm=1.21.2-00 kubectl=1.21.2-00 --allow-change-held-packages
sudo apt-get install -y kubelet kubeadm kubectl --allow-change-held-packages
sudo apt-mark hold kubelet kubeadm kubectl
sudo kubeadm version
