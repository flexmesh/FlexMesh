#ifndef __CLICK_CONTEXT_CONTROL__
#define __CLICK_CONTEXT_CONTROL__

header_type while_metadata_t {
    fields {
        value : 8;
        threshold : 8;
    }
}

metadata while_metadata_t while_metadata;

header_type for_metadata_t {
    fields {
        i : 8;
        threshold : 8;
    }
}

metadata for_metadata_t for_metadata;

header_type if_metadata_t {
    fields {
        left  : 8;
        right : 8;
    }
}

metadata if_metadata_t if_metadata;


header_type condition_metadata_t {
    fields {
        condition : 8;
    }
}

metadata condition_metadata_t condition_metadata; 

action loop(bitmap) {
    SET_FLEX_STATE(0);
    SET_FLEX_INGRESS_BITMAP(bitmap);
    resubmit(reserve_fields);
}

action loop_end(state, bitmap) {
    SET_FLEX_STATE(state);
    SET_FLEX_INGRESS_BITMAP(bitmap);
}



#endif