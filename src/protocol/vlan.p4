#ifndef VXLAN_PROTO
#define VXLAN_PROTO

#ifndef ETH_TYPE_VLAN
#define ETH_TYPE_BF_FABRIC    0x9000
#define ETH_TYPE_VLAN         0x8100
#define ETH_TYPE_QINQ         0x9100
#define ETH_TYPE_MPLS         0x8847
#define ETH_TYPE_IPv4         0x0800
#define ETH_TYPE_IPv6         0x86dd
#define ETH_TYPE_ARP          0x0806
#define ETH_TYPE_RARP         0x8035
#define ETH_TYPE_NSH          0x894f
#define ETH_TYPE_ETHERNET     0x6558
#define ETH_TYPE_ROCE         0x8915
#define ETH_TYPE_FCOE         0x8906
#define ETH_TYPE_TRILL        0x22f3
#define ETH_TYPE_VNTAG        0x8926
#define ETH_TYPE_LLDP         0x88cc
#define ETH_TYPE_LACP         0x8809
#endif

header_type vlan_t {
    fields {
        pcp : 3;
        cfi : 1;
        vid : 12;
        eth_type : 16;
    }
}

header vlan_t vlan;

parser parse_vlan {
    extract(vlan);
#ifdef L2_METADATA
    set_metadata(l2_metadata.eth_type, vlan.eth_type);
#endif
    return select(vlan.eth_type) {
        CASE_PARSE_IPv4
        CASE_PARSE_IPv6
        default : ingress;
    }
}


#define CASE_PARSE_VLAN 0x8100 : parse_vlan;


header vlan_t inner_vlan;

parser parse_inner_vlan {
    parse(inner_vlan);
     return select(inner_vlan.eth_type) {
        CASE_PARSE_IPv4
        CASE_PARSE_IPv6
        default : ingress;
    }
}


#define CASE_PARSE_INNER_VLAN 0x8100 : parse_inner_vlan;


#endif