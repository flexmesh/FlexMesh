sudo ip netns add h1
sudo ip netns add h2

sudo ip link set p4p1 netns h1
sudo ip link set p4p2 netns h2

sudo ip netns exec h1 ifconfig lo up
sudo ip netns exec h2 ifconfig lo up

sudo ip netns exec h1 ifconfig p4p1 hw ether 802200010001
sudo ip netns exec h2 ifconfig p4p2 hw ether 802200010002

sudo ip netns exec h1 ifconfig p4p1 10.0.0.1  up promisc
sudo ip netns exec h2 ifconfig p4p2 10.0.0.2  up promisc

sudo ip netns exec h1 arp -s 10.0.0.2 80:22:00:01:00:02
sudo ip netns exec h2 arp -s 10.0.0.1 80:22:00:01:00:01


#bash ${SWITCH_EXE} ${JSON_FILE} -i 1@veth1 -i 2@veth2 ${2} --thrift-port 9091

