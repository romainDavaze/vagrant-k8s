#!/usr/bin/env bash

kubeadm join master-1:6443 --token $(cat synced-folder/token) \
    --discovery-token-ca-cert-hash sha256:$(cat synced-folder/token-ca-cert-hash)