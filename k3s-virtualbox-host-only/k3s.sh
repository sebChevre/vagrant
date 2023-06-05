#!/bin/bash
MASTER_IP=$1
echo "**** Begin installing k3s, masterIp = ${MASTER_IP}"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--bind-address=${MASTER_IP} --node-external-ip=${MASTER_IP} --flannel-iface=eth1" INSTALL_K3S_VERSION=v1.19.5+k3s1 K3S_KUBECONFIG_MODE="644" sh -
NODE_TOKEN="/var/lib/rancher/k3s/server/node-token"
while [ ! -e ${NODE_TOKEN} ]
do
    sleep 2
done
cat ${NODE_TOKEN}
cp ${NODE_TOKEN} /vagrant/
KUBE_CONFIG="/etc/rancher/k3s/k3s.yaml"
cp ${KUBE_CONFIG} /vagrant/
echo "**** End installing k3s"