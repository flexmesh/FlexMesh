#ifndef __CLICK_REWIND__
#define __CLICK_REWIND__


#include "macro.p4"
#include "field_list.p4"

action rewind (state, bitmap) {
    SET_FLEX_STATE(state);
    SET_FLEX_INGRESS_BITMAP(bitmap);
    resubmit(reserve_fields);

}

table rewind_table {
    reads {
        FLEX_ID : exact;
        FLEX_STATE : exact;
    }
    actions {
        rewind;
    }
}

control pipeline_rewind {
    if (FLEX_ID != 0) {
        apply(rewind_table);
    }
}

#endif