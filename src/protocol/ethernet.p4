#ifndef ETHERNET_PROTO
#define ETHERNET_PROTO

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


header_type ethernet_t {
    fields {
        dst_addr : 48;
        src_addr : 48;
        eth_type : 16;
    }
}

header ethernet_t ethernet;

parser parse_ethernet {
    extract(ethernet);
    return select(ethernet.eth_type) {
#ifdef CASE_PARSE_VLAN
        CASE_PARSE_VLAN
#endif
#ifdef CASE_PARSE_MPLS
        CASE_PARSE_MPLS
#endif
#ifdef CASE_PARSE_IPv4
        CASE_PARSE_IPv4
#endif
#ifdef CASE_PARSE_ARP
        CASE_PARSE_ARP
#endif
#ifdef CASE_PARSE_IPv6
        CASE_PARSE_IPv6
#endif
#ifdef CASE_PARSE_PPPOE
        CASE_PARSE_PPPOE
#endif
#ifdef CASE_PARSE_ROCE
        CASE_PARSE_ROCE
#endif
        default : ingress;
    }
}


header ethernet_t inner_ethernet;

parser parse_inner_ethernet {
    extract(inner_ethernet);
    return select(ethernet.eth_type) {
#ifdef CASE_PARSE_INNER_VLAN
        CASE_PARSE_INNER_VLAN
#endif
#ifdef CASE_PARSE_INNER_MPLS
        CASE_PARSE_INNER_MPLS
#endif
#ifdef CASE_PARSE_INNER_IPv4
        CASE_PARSE_INNER_IPv4
#endif
#ifdef CASE_PARSE_INNER_IPv6
        CASE_PARSE_INNER_IPv6
#endif
        default : ingress;
    }
}

#endif