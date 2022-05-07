cat << EOF | sudo sh -x
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
kubeadm reset -f
/bin/rm -rf /etc/cni/net.d
EOF