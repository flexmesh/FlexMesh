#ifndef CONDITION_FEATURE_MODULE
/**
 * Condition module parameters.
 */

#ifndef CONDITION_TABLE_SIZE
#define CONDITION_TABLE_SIZE 512
#endif

action condition_branch(state, bitmap) {
    SET_FLEX_STATE(state);
    SET_FLEX_INGRESS_BITMAP(bitmap);
}

table condition_table_1 {
    reads {
        flex_metadata.click_id : exact;
        condition_metadata.condition : exact;
    }
    actions {
         condition_branch;
    }
    size : 1024;
}

table condition_table_2 {
    reads {
        flex_metadata.click_id : exact;
        condition_metadata.condition : exact;
    }
    actions {
         condition_branch;
    }
    size : 1024;
}

table condition_table_3 {
    reads {
        flex_metadata.click_id : exact;
        condition_metadata.condition : exact;
    }
    actions {
         condition_branch;
    }
    size : 1024;
}

table condition_table_4 {
    reads {
        flex_metadata.click_id : exact;
        condition_metadata.condition : exact;
    }
    actions {
         condition_branch;
    }
    size : 1024;
}


MODULE_INGRESS(condition) {
    apply(condition_table_1);
    apply(condition_table_2);
    apply(condition_table_3);
    apply(condition_table_4);
}

#undef CONDITION_TABLE_SIZE
#endif