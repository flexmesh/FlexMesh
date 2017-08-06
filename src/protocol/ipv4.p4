#ifndef IPv4_PROTO
#define IPv4_PROTO

#define IP_PROTO_ICMP              1
#define IP_PROTO_IGMP              2
#define IP_PROTO_IPV4              4
#define IP_PROTO_TCP               6
#define IP_PROTO_UDP               17
#define IP_PROTO_IPv6              41
#define IP_PROTO_GRE               47
#define IP_PROTO_IPSEC_ESP         50
#define IP_PROTO_IPSEC_AH          51
#define IP_PROTO_ICMPV6            58
#define IP_PROTO_EIGRP             88
#define IP_PROTO_OSPF              89
#define IP_PROTO_PIM               103
#define IP_PROTO_VRRP              112

header_type ipv4_t {
    fields {
        version : 4;
        ihl : 4;
        diffserv : 8;
        total_len : 16;
        identification : 16;
        flags : 3;
        frag_offset : 13;
        ttl : 8;
        proto : 8;
        checksum : 16;
        src_addr : 32;
        dst_addr: 32;
    }
}

header ipv4_t ipv4;

parser parse_ipv4 {
    extract(ipv4);
    return select(ipv4.proto) {
#ifdef CASE_PARSE_ICMP
    CASE_PARSE_ICMP
#endif
#ifdef CASE_PARSE_TCP
    CASE_PARSE_TCP
#endif
#ifndef CASE_PARSE_UDP
    CASE_PARSE_UDP
#endif
    default : ingress;
    }
}

#define CASE_PARSE_IPv4 0x0800 : parse_ipv4;

header ipv4_t inner_ipv4;

parser parse_inner_ipv4 {
    extract(inner_ipv4);
    return select(inner_ipv4.proto) {
#ifdef CASE_PARSE_INNER_ICMP
    CASE_PARSE_INNER_ICMP
#endif
#ifdef CASE_PARSE_INNER_TCP
    CASE_PARSE_INNER_TCP
#endif
#ifdef CASE_PARSE_INNER_UDP
    CASE_PARSE_INNER_UDP
#endif
    default : ingress;
    }
}

#define CASE_PARSE_INNER_IPv4 0x0800 : parse_inner_ipv4;


#endif
