#!/bin/bash

./init.sh

# 加入Kubernetes集群 (使用从master节点获取的token和master的IP地址)
sudo kubeadm join <master1_ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
