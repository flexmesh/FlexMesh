#ifndef CONDITION_FEATURE_MODULE
/**
 * Condition module parameters.
 */

#ifndef IFCONST_TABLE_SIZE
#define IFCONST_TABLE_SIZE 512
#endif

action ifconst_branch(state, bitmap) {
    SET_FLEX_STATE(state);
    SET_FLEX_INGRESS_BITMAP(bitmap);
}

table ifconst {
    reads {
        flex_metadata.click_id : exact;
        if_metadata.left : range;
    }
    actions {
         ifconst_branch;
    }
    size : IFCONST_TABLE_SIZE;
}


MODULE_INGRESS(ifconst) {
    apply(ifconst);
}

#undef CONDITION_TABLE_SIZE
#endif