#!/bin/bash

echo "**** Begin installing k3s master node ****"
echo "> Cleaning old config..."
# clean old config files
rm /vagrant/k3s_config/*

echo "> Master node IP:$MASTER_NODE_IP"
echo ">$NBRE_OF_NODES worker nodes configred" 

# master node configuration, write to host file
echo "$MASTER_NODE_IP $CONTROL_PLANE_NAME.$DOMAIN $CONTROL_PLANE_NAME" >> /etc/hosts 

# worker nodes iteration, write to hosts file
max=$NBRE_OF_NODES
for NODE_INDEX in `eval echo {1..$max}`
do
    echo "$NODE_START_IP$NODE_INDEX $WORKER_NODE_NAME$NODE_INDEX.$DOMAIN $WORKER_NODE_NAME$NODE_INDEX" >> /etc/hosts
done

# get k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--bind-address=$MASTER_NODE_IP --node-external-ip=$MASTER_NODE_IP" INSTALL_K3S_VERSION=$K3S_VERSION K3S_KUBECONFIG_MODE="644" sh -
NODE_TOKEN="/var/lib/rancher/k3s/server/node-token"

#wait until node_token available
while [ ! -e ${NODE_TOKEN} ]
do
    sleep 2
done

#copy config files
echo "> Copy k3s config to local folder, node_token and k3s.yaml"
cp ${NODE_TOKEN} /vagrant/k3s_config/
KUBE_CONFIG="/etc/rancher/k3s/k3s.yaml"
cp ${KUBE_CONFIG} /vagrant/k3s_config/

echo "**** End installing k3s ****"