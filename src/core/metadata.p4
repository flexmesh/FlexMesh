#ifndef __CLICK_METADATA__
#define __CLICK_METADATA__

/****************************************************
 * intrinsic_metadata_t
 * P4 intrinsic metadata (mandatory)
 ****************************************************/
header_type intrinsic_metadata_t {
	fields {
        ingress_global_timestamp : 48;
        lf_field_list : 8;
        mcast_grp : 16;
        egress_rid : 16;
        resubmit_flag : 8;
        recirculate_flag : 8;
	}
}

metadata intrinsic_metadata_t intrinsic_metadata;


/**
 * Metadata.
 */

header_type flex_metadata_t {
    fields {
        ingress_bitmap  : 16; // Supprort 64 mododules now.
        egress_bitmap   : 16;
        id      : 16; // Chain ID.
        ingress_state   : 8 ; // Chain state.
    }
}

metadata click_metadata_t click_metadata;

#endif