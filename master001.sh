#!/bin/bash

./init.sh

# 初始化Kubernetes master节点
sudo kubeadm init --kubernetes-version=1.29.0 --pod-network-cidr=10.244.0.0/16

# 设置kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 安装Flannel网络插件
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# 获取加入集群的token
echo "Please wait for the master to be fully initialized, then run the join command:"
sleep 5
sudo kubeadm token create --print-join-command
