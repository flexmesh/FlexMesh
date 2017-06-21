#ifndef IPv6_PROTO

#define IPv6_PROTO

header_type ipv6_t {
    fields {
        version : 4;
        traffic_class : 8;
        flow_label : 20;
        payload_len : 16;
        next_hdr : 8;
        hop_limit : 8;
        src_addr : 128;
        dst_addr : 128;
    }
}

header ipv6_t ipv6;


parser parse_ipv6 {
    extract(ipv6);
    return select(ipv6.next_hdr) {
        CASE_PARSE_TCP
        CASE_PARSE_UDP
        default : ingress;
    }
}

#define CASE_PARSE_IPv6 0x86dd : parse_ipv6;



header ipv6_t inner_ipv6;


parser parse_ipv6 {
    extract(inner_ipv6);
    return select(inner_ipv6.next_hdr) {
        CASE_PARSE_INNER_TCP
        CASE_PARSE_INNER_UDP
        default : ingress;
    }
}

#define CASE_PARSE_INNER_IPv6 0x86dd : parse_inner_ipv6;



#endif