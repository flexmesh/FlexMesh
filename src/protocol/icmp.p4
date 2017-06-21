#ifndef ICMP_PROTO
#define ICMP_PROTO

header_type icmp_t {
    fields {
        type : 8;
        code : 8;
        checksum : 16;
    }
}

header icmp_t icmp;

parser parse_icmp {
	extract(icmp);
	return ingress;
}

#define CASE_PARSE_ICMP 1 : parse_icmp;

#endif