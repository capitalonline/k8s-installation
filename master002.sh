#!/bin/bash

./init.sh

sudo kubeadm join <master1_ip>:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
