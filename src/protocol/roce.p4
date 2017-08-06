#ifndef ROCE_PROTO
#define ROCE_PROTO

#define ETH_TYPE_ROCE         0x8915

header_type roce_t {
    fields {
        ib_grh : 320;
        ib_bth : 96;
    }
}

header_type roce_v2_t {
    fields {
        ib_bth : 96;
    }
}

header roce_t roce;
header roce_v2_t roce_v2;


parser parse_roce {
    extract(roce);
    return ingress;
}

parser parse_roce_v2 {
    extract(roce_v2);
    return ingress;
}

#define CASE_PARSE_ROCE 0x8915 : parse_roce;
#define CASE_PARSE_ROCE_V2 4791 : parse_roce_v2;


#endif