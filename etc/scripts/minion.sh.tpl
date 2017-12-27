#!/bin/bash

setenforce 0

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes Repository
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
EOF

yum clean all

yum install -y docker-io
systemctl start docker.service
systemctl enable docker.service
systemctl enable kubelet.service

# Fix preflight error
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables

yum install -y kubelet kubeadm kubectl kubernetes-cni

kubeadm join --discovery-token-unsafe-skip-ca-verification --token ${cluster_token} ${master_ip}:6443

touch /tmp/script_finished
