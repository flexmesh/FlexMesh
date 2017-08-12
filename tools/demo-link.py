#! /bin/python
import os

def create_link(peer1, peer2):
    os.popen("ip link add %s type veth peer name %s"%(peer1, peer2))


def setup_links():
    create_link('h1_1', 's1_1')
    create_link('s1_2', 's2_1')
    create_link('s2_2', 's3_1')
    create_link('s2_3', 's4_1')
    create_link('s3_2', 's4_2')
    create_link('s3_3', 's5_1')
    create_link('s4_3', 's5_2')
    create_link('h2_1', 's5_3')

def clear_links():
	pass


if __name__ == "__main__":
    setup_links()
