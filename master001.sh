#!/bin/bash

# 检查是否传入了pod网络CIDR参数
if [ -z "$1" ]; then  echo "Usage: $0 --pod-network-cidr=<CIDR>"
  exit 1
fi

POD_NETWORK_CIDR=$1
./init.sh

# 初始化Kubernetes master节点
sudo kubeadm init --kubernetes-version=1.29.0 --pod-network-cidr=$POD_NETWORK_CIDR

# 设置kubectl
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 获取加入集群的token
echo "Please wait for the master to be fully initialized, then run the join command:"
sleep 5
sudo kubeadm token create --print-join-command
