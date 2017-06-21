#ifndef GRE_PROTO
#define GRE_PROTO

header_type gre_t {
    fields {
        C : 1;
        R : 1;
        K : 1;
        S : 1;
        s : 1;
        recurse : 3;
        flags : 5;
        ver : 3;
        proto : 16;
    }
}


header gre_t gre;

parser parse_gre {
    extract(gre);

#ifdef TUNNEL_METADATA
    set_metadata(tunnel_metadata.ingress_tunnel_type, TUNNEL_GRE);
#endif

    return inress;
}

#define CASE_PARSE_GRE  4754 : parse_gre; \
                        4755 : parse_gre;


/**
 * NVGRE header type.
 */
header_type nvgre_t {
    fields {
        tni : 24;
        flow_id : 8;
    }
}


header nvgre_t nvgre;

parser parse_nvgre {
    extract(nvgre);
    return ingress;
}

#endif