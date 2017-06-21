#ifndef VXLAN_PROTO
#define VXLAN_PROTO

header_type vxlan_t {
    fields {
        flags : 8;
        reserved : 24;
        vni : 24;
        reserved2 : 8;
    }
}

header vxlan_t vxlan;

parser parse_vxlan {
    extract(vxlan);
#ifdef TUNNEL_METADATA
    set_metadata(tunnel_metadata.ingress_tunnel_type, TUNNEL_VXLAN);
#endif
    return parse_inner_ethernet;
}

#define CASE_PARSE_VXLAN 4789 : parse_vxlan;

#endif