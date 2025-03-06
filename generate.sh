NETWORK_NAME="k_network"
POD_SUBNETS=("10.200.0.0/24" "10.200.1.0/24" "10.200.2.0/24")
INDEX=0

echo "IPV4_ADDRESS FQDN HOSTNAME POD_SUBNET" > ./machines.txt

for container in jumpbox k_server k_worker_0 k_worker_1; do
    IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container)
    FQDN="${container}.kubernetes.local"
    HOSTNAME=$container
    POD_SUBNET=${POD_SUBNETS[$INDEX]}
    INDEX=$((INDEX+1))
    echo "done"

    if [ "$container" == "jumpbox" ]; then
        echo "$IP $FQDN $HOSTNAME" >> ./machines.txt
    else
        echo "$IP $FQDN $HOSTNAME $POD_SUBNET" >> ./machines.txt
    fi
done
