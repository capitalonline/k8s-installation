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

# 加入Kubernetes集群 (使用从master节点获取的token和master的IP地址)
sudo kubeadm join <master1_ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
