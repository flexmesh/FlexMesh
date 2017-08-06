#ifndef BFP_PROTO
#define BFP_PROTO

header_type bfd_t {
    fields {
        version : 3;
        diag : 5;
        state : 2;
        p : 1;
        f : 1;
        c : 1;
        a : 1;
        d : 1;
        m : 1;
        detectMult : 8;
        len : 8;
        myDiscriminator : 32;
        yourDiscriminator : 32;
        desiredMinTxInterval : 32;
        requiredMinRxInterval : 32;
        requiredMinEchoRxInterval : 32;
    }
}

#endif