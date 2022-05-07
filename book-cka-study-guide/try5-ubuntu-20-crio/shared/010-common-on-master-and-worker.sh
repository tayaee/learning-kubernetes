# ubuntu 20.04, cri-o, 1 master, 2 worker, pod-network-cidr=10.244.0.0/16
# https://computingforgeeks.com/deploy-kubernetes-cluster-on-ubuntu-with-kubeadm/

export POD_NETWORK=10.244.0.0

#
# kubernetes
#

sudo apt update
sudo apt-get install bash-completion
# sudo apt -y full-upgrade
# [ -f /var/run/reboot-required ] && sudo reboot -f
sudo apt -y install curl apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt -y install vim git curl wget kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

kubectl version --client && kubeadm version

sudo sed -i '/swap/ s/^\(.*\)$/#\1/g' /etc/fstab
grep -v '^#' /etc/fstab | grep swap || echo OK
sudo swapoff -a

# Enable kernel modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Add some settings to sysctl
sudo tee /etc/sysctl.d/kubernetes.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload sysctl
sudo sysctl --system

#
# cri-o
#

# Ensure you load modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Set up required sysctl params
sudo tee /etc/sysctl.d/kubernetes.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload sysctl
sudo sysctl --system

# Add Cri-o repo
tee ~/cri-o-repo.sh << EOF
export OS="xUbuntu_20.04"
export VERSION=1.23
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/\$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/\$VERSION/\$OS/ /" > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list
curl -sL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:\$VERSION/\$OS/Release.key | apt-key add -
curl -sL https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/\$OS/Release.key | apt-key add -
EOF
sudo sh -x ~/cri-o-repo.sh

# Install CRI-O
sudo apt update
sudo apt install -y cri-o cri-o-runc

# Update CRI-O CIDR subnet
sudo sed -i "s/10.85.0.0/$POD_NETWORK/g" /etc/cni/net.d/100-crio-bridge.conf

# Start and enable Service
sudo systemctl daemon-reload
sudo systemctl restart crio
sudo systemctl enable crio
sudo systemctl status crio --no-pager
