#!/bin/bash

echo "**** Begin installing k3s worker node ****"
# write master nodes info to hosts file
echo "$MASTER_NODE_IP $CONTROL_PLANE_NAME.$DOMAIN $CONTROL_PLANE_NAME" >> /etc/hosts 

# worker nodes iteration, writw to hosts file
max=$NBRE_OF_NODES
for NODE_INDEX in `eval echo {1..$max}`
do
    echo $NODE_START_IP$NODE_INDEX $WORKER_NODE_NAME$NODE_INDEX.$DOMAIN  $WORKER_NODE_NAME$NODE_INDEX >> /etc/hosts
done

curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=$K3S_VERSION K3S_KUBECONFIG_MODE="644" K3S_URL=$MASTER_NODE_URL K3S_TOKEN=$(cat /vagrant/k3s_config/node-token) sh -

echo "**** End installing k3s worker node ****"