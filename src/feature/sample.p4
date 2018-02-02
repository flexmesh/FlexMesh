/**
 * A sample module for FlexMesh
 */

#ifndef MODULE
#define MODULE sample

table sample {
    actions {
        nop;
    }
}

MODULE_INGRESS(sample) {
    apply(sample);
}

#undef MODULE