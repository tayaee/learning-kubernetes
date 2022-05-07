# https://containerjournal.com/features/setting-up-kubernetes-in-an-on-premises-environment/


#
# init master
#

sudo kubeadm init --pod-network-cidr=10.211.0.0/16 --apiserver-advertise-address=192.168.1.69

lsmod | grep br_netfilter
sudo systemctl enable kubelet
# sudo kubeadm config images pull

# Containerd
sudo kubeadm config images pull --cri-socket /run/containerd/containerd.sock

# kubectl -n kube-system get cm kubeadm-config -o yaml
# sudo kubeadm reset -f
# sudo rm -rf /etc/cni/net.d
# sudo kubeadm init --pod-network-cidr=10.0.0.1/16
# sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --cri-socket /run/containerd/containerd.sock --upload-certs --control-plane-endpoint=kube-master.example.com
# sudo kubeadm init --apiserver-advertise-address=172.16.28.10 --pod-network-cidr=172.18.0.0/16
sudo kubeadm init --apiserver-advertise-address=10.8.8.10 --pod-network-cidr=172.18.0.0/16

mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# health check
kubectl cluster-info

# install cni
# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml

kubectl get nodes

# add 2nd control plan
# kubeadm join kube-master.example.com:6443 --token sr4l2l.2kvot0pfalh5o4ik --discovery-token-ca-cert-hash sha256:c692fb047e15883b575bd6710779dc2c5af8073f7cab460abd181fd3ddb29a18 --control-plane

#
# worker
#

# sudo kubeadm join 10.0.2.15:6443 --token n0mndu.u6xwa6hk942xtakl --discovery-token-ca-cert-hash sha256:38507e1c4ab08e23808f42f8f97b075d5990b62aa3f57cdc1f0ec806a6edfee4

# kubectl get nodes