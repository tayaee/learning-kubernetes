# https://adamtheautomator.com/install-kubernetes-ubuntu/


#
# init cluster on master
#

sudo sed -i '/swap/ s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

# hostname -I
# 10.0.2.15 192.168.1.66
# sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.0.2.15
# kubectl -n kube-system get cm kubeadm-config -o yaml
# sudo kubeadm reset -f
# sudo kubeadm init --pod-network-cidr=10.1.0.0/16 --apiserver-advertise-address=192.168.1.66
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
