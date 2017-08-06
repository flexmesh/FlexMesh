#ifndef INT_PROTO
#define INT_PROTO

header_type int_header_t {
    fields {
        ver                     : 2;
        rep                     : 2;
        c                       : 1;
        e                       : 1;
        rsvd1                   : 5;
        ins_cnt                 : 5;
        max_hop_cnt             : 8;
        total_hop_cnt           : 8;
        instruction_mask_0003   : 4;   // split the bits for lookup
        instruction_mask_0407   : 4;
        instruction_mask_0811   : 4;
        instruction_mask_1215   : 4;
        rsvd2                   : 16;
    }
}

header int_t int;

header_type int_switch_id_header_t {
    fields {
        bos                 : 1;
        switch_id           : 31;
    }
}

header_type int_ingress_port_id_header_t {
    fields {
        bos                 : 1;
        ingress_port_id_1   : 15;
        ingress_port_id_0   : 16;
    }
}

header_type int_hop_latency_header_t {
    fields {
        bos                 : 1;
        hop_latency         : 31;
    }
}

header_type int_q_occupancy_header_t {
    fields {
        bos                 : 1;
        q_occupancy1        : 7;
        q_occupancy0        : 24;
    }
}

header_type int_ingress_tstamp_header_t {
    fields {
        bos                 : 1;
        ingress_tstamp      : 31;
    }
}

header_type int_egress_port_id_header_t {
    fields {
        bos                 : 1;
        egress_port_id      : 31;
    }
}

header_type int_q_congestion_header_t {
    fields {
        bos                 : 1;
        q_congestion        : 31;
    }
}

header_type int_egress_port_tx_utilization_header_t {
    fields {
        bos                         : 1;
        egress_port_tx_utilization  : 31;
    }
}

header_type int_value_t {
    fields {
        bos         : 1;
        val         : 31;
    }
}

header_type vxlan_gpe_int_header_t {
    fields {
        int_type    : 8;
        rsvd        : 8;
        len         : 8;
        next_proto  : 8;
    }
}

header int_header_t                             int_header;
header int_switch_id_header_t                   int_switch_id_header;
header int_ingress_port_id_header_t             int_ingress_port_id_header;
header int_hop_latency_header_t                 int_hop_latency_header;
header int_q_occupancy_header_t                 int_q_occupancy_header;
header int_ingress_tstamp_header_t              int_ingress_tstamp_header;
header int_egress_port_id_header_t              int_egress_port_id_header;
header int_q_congestion_header_t                int_q_congestion_header;
header int_egress_port_tx_utilization_header_t  int_egress_port_tx_utilization_header;
header vxlan_gpe_int_header_t                   vxlan_gpe_int_header;


parser parse_gpe_int_header {
    // GPE uses a shim header to preserve the next_protocol field
    extract(vxlan_gpe_int_header);
    set_metadata(int_metadata.gpe_int_hdr_len, latest.len);
    return parse_int_header;
}


parser parse_int_header {
    extract(int_header);
    set_metadata(int_metadata.instruction_cnt, latest.ins_cnt);
    return select (latest.rsvd1, latest.total_hop_cnt) {
        0x000: ingress;
#ifdef INT_EP_ENABLE
        0x000 mask 0xf00: parse_int_val;
#endif
        0 mask 0: ingress;
        // never transition to the following state
        default: parse_all_int_meta_value_heders;
    }
}

#ifdef INT_EP_ENABLE
#define MAX_INT_INFO    24
header int_value_t int_val[MAX_INT_INFO];

parser parse_int_val {
    extract(int_val[next]);
    return select(latest.bos) {
        0 : parse_int_val;
        1 : parse_inner_ethernet;
    }
}
#endif

parser parse_all_int_meta_value_heders {
    extract(int_switch_id_header);
    extract(int_ingress_port_id_header);
    extract(int_hop_latency_header);
    extract(int_q_occupancy_header);
    extract(int_ingress_tstamp_header);
    extract(int_egress_port_id_header);
    extract(int_q_congestion_header);
    extract(int_egress_port_tx_utilization_header);
#ifdef INT_EP_ENABLE
    return parse_int_val;
#else
    return ingress;
#endif
}

#endif