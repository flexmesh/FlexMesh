#!/bin/bash

SWITCH_DIR=/home/netarchlab/behavioral-model/targets/simple_switch

INTF_S1_1='-i 1@e1_1'
INTF_S1_2='-i 2@e1_2'
INTF_S2_1='-i 1@s2_1'
INTF_S2_2='-i 2@s2_2'
INTF_S2_3='-i 3@s2_3'
INTF_S3_1='-i 1@s3_1'
INTF_S3_2='-i 2@s3_2'
INTF_S3_3='-i 3@s3_3'
INTF_S4_1='-i 1@s4_1'
INTF_S4_2='-i 2@s4_2'
INTF_S4_3='-i 3@s4_3'
INTF_S1_1='-i 1@s5_1'
INTF_S1_2='-i 2@s5_2'
INTF_S1_3='-i 3@s5_3'
LOG='-L off'

SWITCH_DBG_DIR=/home/netarchlab/bmv2-debug/targets/simple_switch

sudo python demo-link.py
sudo bash demo-host.sh

cd $SWITCH_DIR



# E1
for i in `seq 1`
do
{
    sudo ./simple_switch flex4.json $INTF_S1_1 $INTF_S1_2 $LOG --thrift-port 9090 --device-id 1
} &
done

# E2
for i in `seq 1`
do
{
    sudo ./simple_switch flex4.json $INTF_S2_1 $INTF_S2_2 $INTF_S2_3 $LOG --thrift-port 9091 --device-id 2
} &
done

# E3
for i in `seq 1`
do
{
    sudo ./simple_switch flex4.json $INTF_S3_1 $INTF_S3_2 $INTF_S3_3 $LOG --thrift-port 9092 --device-id 3
} &
done

# E4
for i in `seq 1`
do
{
    sudo ./simple_switch flex4.json $INTF_S4_1 $INTF_S4_2 $INTF_S4_3 $LOG --thrift-port 9093 --device-id 4
    #sudo $SWITCH_DBG_DIR/simple_switch flex4.json $INTF_E4_1 $INTF_E4_2 $INTF_E4_3 --log-console --thrift-port 9093
} &
done

# A1

sudo ./simple_switch flex4.json $INTF_S5_1 $INTF_S5_2 $INTF_S5_3 $LOG --thrift-port 9094 --device-id 5
