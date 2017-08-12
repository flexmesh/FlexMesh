#! /bin/bash

# export TEST_ROOT='/home/ubuntu/vp4-test'
# export SWITCH_ROOT='/home/ubuntu/onos-p4-dev/onos0p4-bmv2/targets/simple_switch'
# export SWITCH_EXE='/home/ubuntu/onos-p4-dev/onos-p4-bmv2/targets/simple_switch/simple_switch'

# JSON_FILE=${TEST_ROOT}/${1}/conf.json

# Remove existing name spaces
ip netns | xargs -I {} sudo ip netns delete {}

sudo ip netns add h1
sudo ip netns add h2

sudo ip link set h1_1 netns h1
sudo ip link set h2_1 netns h2

sudo ip netns exec h1 ifconfig lo up
sudo ip netns exec h2 ifconfig lo up

sudo ip netns exec h1 ifconfig h1_1 hw ether 800000000001
sudo ip netns exec h2 ifconfig h2_1 hw ether 800000000002

sudo ip netns exec h1 ifconfig h1_1 10.0.0.1  up
sudo ip netns exec h2 ifconfig h2_1 10.0.0.2  up

sudo ip netns exec h1 arp -s 10.0.0.2 80:00:00:00:00:02
sudo ip netns exec h2 arp -s 10.0.0.1 80:00:00:00:00:01

sudo ifconfig veth3 up
sudo ifconfig veth4 up

#bash ${SWITCH_EXE} ${JSON_FILE} -i 1@veth1 -i 2@veth2 ${2} --thrift-port 9091

