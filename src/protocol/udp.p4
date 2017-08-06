#ifndef UDP_PROTO
#define UDP_PROTO
header_type udp_t {
    fields {
        src_port : 16;
        dst_port : 16;
        length_ : 16;
        checksum : 16;
    }
}

header udp_t udp;

parser parse_udp {
    extract(udp);
#ifdef L4_METADATA
    set_metadata(l4_metadata.src_port, udp.src_port);
    set_metadata(l4_metadata.dst_port, udp.dst_port);
    set_metadata(l4_metadata.l4_type, L4_TYPE_UDP);
#endif
    return select(udp.dst_port) {
#ifdef CASE_PARSE_GRE 
        CASE_PARSE_GRE
#endif
#ifdef CASE_PARSE_VXLAN
        CASE_PARSE_VXLAN
#endif
#ifdef CASE_PARSE_ROCE_V2 
        CASE_PARSE_ROCE_V2
#endif
#ifdef CASE_PARSE_LISP
        CASE_PARSE_LISP
#endif
        default : ingress;
    }
}

#define CASE_PARSE_UDP 17 : parse_udp;


header udp_t inner_udp;

parser parse_inner_udp {
    extract(inner_udp);
    return ingress;
}

#define CASE_PARSE_INNER_UDP 17 : parse_inner_udp;



#endif