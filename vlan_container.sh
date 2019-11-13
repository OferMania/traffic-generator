set -eux

sudo mkdir -p /var/run/netns
docker run -d --name sleeper --net none debian:buster sleep infinity
sudo ln -sfT /proc/$(docker inspect --format '{{.State.Pid}}' sleeper)/ns/net /var/run/netns/sleeper
sudo ln -sfT /proc/$(docker inspect --format '{{.State.Pid}}' trex)/ns/net /var/run/netns/trex

sudo ip link add veth1 type veth peer name veth2
sudo ip link add link veth1 veth1.24 type vlan proto 802.1ad id 24
sudo ip link add link veth2 veth2.12 type vlan proto 802.1ad id 12
sudo ip link add link veth2 veth2.24 type vlan proto 802.1ad id 24
sudo ip link set veth1.24 netns trex
sudo ip link set veth2.24 netns sleeper
sudo ip link set veth1 up
sudo ip link set veth2 up
sudo ip -n trex addr add 1.1.1.1/24 dev veth1.24
sudo ip -n sleeper addr add 1.1.1.2/24 dev veth2.24
