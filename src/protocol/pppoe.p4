#ifndef PPPOE_PROTO
#define PPPOE_PROTO

header_type pppoe_t { 
    fields {
        version : 4;
        type : 4;
        code : 8;
        session_id : 16;
        leng : 16;
        proto : 16;
    }
}

header pppoe_t pppoe;

parser parse_pppoe {
    extract(pppoe);
    return select(pppoe.proto) {
#ifdef IPv4_PROTO
        0x0021 : parse_ipv4;
#endif
        default : ingress;
    }
}

#define CASE_PARSE_PPPOE 0x8864 : parse_pppoe;

#endif