#define INGRESS_MODULE_NUM 16
#define EGRESS_MODULE_NUM 16


#define REDUNDANT_NUM 0

#define ENABLE_INITIALIZER 1
#define ENABLE_REWINDER    0
#define L2_SWITCH_LEARN    0

// #define INIT_MATCH standard_metadata.ingress_port: ternary;

#define INIT_ETH_MATCH
// #define INIT_IPv4_MATCH
#define INIT_IPv6_MATCH
// #define INIT_TCP_MATCH
// #define INIT_UDP_MATCH



#define TOFINO_TARGET 1
#define TARGET 1