#ifndef MPLS_PROTO
#define MPLS_PROTO


header_type mpls_t {
    fields {
        label : 20;
        exp : 3;
        bos : 1;
        ttl : 8;
    }
}


header mpls_t mpls;

parser parse_mpls {
	extract(mpls);
	return ingress;
}

#define CASE_PARSE_MPLS 0x8847 : parse_mpls; \ 
                        0x8848 : parse_mpls;

#endif