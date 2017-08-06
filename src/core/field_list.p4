#ifndef __CLICK_FIELD_LIST__
#define __CLICK_FIELD_LIST__

#include "metadata.p4"

field_list reserve_fields {
    //standard_metadata.ingress_port;
    //standard_metadata.egress_spec;
    //intrinsic_metadata;
    FLEX_INGRESS_BITMAP;
    FLEX_EGRESS_BITMAP;
    FLEX_ID;
}


#endif