/**
 * A sample module for Flex4
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