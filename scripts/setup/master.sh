#!/usr/bin/env bash

kubeadm init --apiserver-advertise-address $(ip address show eth1 | grep inet | head -n 1 | \
    sed "s/^[ \t]*//" | cut -d' ' -f2 | cut -d/ -f1)

mkdir -p /home/$USER/.kube
cp -i /etc/kubernetes/admin.conf /home/$USER/.kube/config
chown $USER:vagrant /home/$USER/.kube/config

openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //' > synced-folder/token-ca-cert-hash
kubeadm token list | head -n 2 | tail -1 | cut -d' ' -f1 > synced-folder/token

KUBECONFIG=/etc/kubernetes/admin.conf kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml