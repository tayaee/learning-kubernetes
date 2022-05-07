# https://computingforgeeks.com/deploy-kubernetes-cluster-on-ubuntu-with-kubeadm/

export POD_NETWORK=10.244.0.0

#
# init master
#

lsmod | grep br_netfilter
sudo systemctl enable kubelet
sudo kubeadm config images pull --cri-socket /var/run/crio/crio.sock

# sudo vi /etc/hosts
# 192.168.1.65 k8s-master01
# 192.168.1.66 k8s-worker01
# 192.168.1.67 k8s-worker02

# sudo kubeadm init --pod-network-cidr=$POD_NETWORK/16 --cri-socket /var/run/crio/crio.sock --upload-certs --control-plane-endpoint=k8s-master01
sudo kubeadm init --pod-network-cidr=$POD_NETWORK/16

mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl cluster-info

# cni
kubectl create -f https://docs.projectcalico.org/manifests/tigera-operator.yaml
kubectl create -f https://docs.projectcalico.org/manifests/custom-resources.yaml

watch kubectl get pods --all-namespaces

#
# second master
#

# sudo vi /etc/hosts
# 192.168.1.65 kube-master
# 192.168.1.66 kube-worker-1
# 192.168.1.67 kube-worker-2

kubeadm join kube-master:6443 \
    --token sr4l2l.2kvot0pfalh5o4ik \
    --discovery-token-ca-cert-hash sha256:c692fb047e15883b575bd6710779dc2c5af8073f7cab460abd181fd3ddb29a18 \
    --control-plane

#
# worker node
#

# sudo vi /etc/hosts
# 192.168.1.65 kube-master
# 192.168.1.66 kube-worker-1
# 192.168.1.67 kube-worker-2

kubeadm join k8s-cluster.computingforgeeks.com:6443 \
  --token sr4l2l.2kvot0pfalh5o4ik \
  --discovery-token-ca-cert-hash sha256:c692fb047e15883b575bd6710779dc2c5af8073f7cab460abd181fd3ddb29a18