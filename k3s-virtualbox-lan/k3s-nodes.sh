#!/bin/bash

echo "**** Begin installing k3s"

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface=eth1" INSTALL_K3S_VERSION=v1.19.5+k3s1 K3S_KUBECONFIG_MODE="644" K3S_URL="https://192.168.3.1:6443" K3S_TOKEN=$(cat /vagrant/node-token) sh -



echo "**** End installing k3s"