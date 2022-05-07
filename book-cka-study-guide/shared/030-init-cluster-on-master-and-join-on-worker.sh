# https://medium.com/@karthikeyan_krishnaswamy/setting-up-a-kubernetes-cluster-on-ubuntu-18-04-4a89c74420f9

# init cluster on master
sudo kubeadm reset -f
sudo kubeadm init --pod-network-cidr 172.17.0.0/16 --apiserver-advertise-address 172.18.0.1 --v=5
# kubectl -n kube-system get cm kubeadm-config -o yaml
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
kubectl get nodes

# join cluster on worker 1
# sudo kubeadm join 172.18.0.1:6443 --token wuanyg.pxw6gbs5enujhc7z --discovery-token-ca-cert-hash sha256:dec6da8dab3ac69f595eebc2559587cc04540380314f0db88609f20168c26926
# sudo kubectl get nodes

# join cluster on worker 2
# sudo kubeadm join 172.18.0.1:6443 --token wuanyg.pxw6gbs5enujhc7z --discovery-token-ca-cert-hash sha256:dec6da8dab3ac69f595eebc2559587cc04540380314f0db88609f20168c26926
# sudo kubectl get nodes
