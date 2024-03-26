#!/bin/bash

# 添加阿里云的APT源
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb http://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
deb-src http://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

# 安装依赖
sudo apt-get update && sudo apt-get install -y apt-transport-https curl

# 添加Kubernetes GPG key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# 更新并安装Kubernetes组件
sudo apt-get update && sudo apt-get install -y kubeadm kubelet kubectl

# 禁用交换分区
sudo sed -i '/ swap / s/^$.*$$/#\1/g' /etc/fstab
sudo swapoff -a

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
