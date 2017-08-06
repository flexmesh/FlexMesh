#ifndef LISP_PROTO
#define LISP_PROTO

header_type lisp_t {
    fields {
        flags : 8;
        nonce : 24;
        instance_id : 24;
        lsbs : 8;
    }
}

header lisp_t lisp;


parser parse_lisp {
    extract(lisp);
    return select(current(0, 4)) {
        0x4 : parse_inner_ipv4;
        0x6 : parse_inner_ipv6;
        default : ingress;
    }
}


#define CASE_PARSE_LISP 4341 : parse_lisp;

#endif