#ifndef __CLICK_MODULE__
#define __CLICK_MODULE__

#include "../feature/l2_switch.p4"
#include "../feature/simple_nat.p4"
#include "../feature/vlan.p4"
#include "../feature/l3_switch.p4"
#include "../feature/simple_acl.p4"
#include "../feature/simple_qos.p4"


#define INGRESS_MODULE_1 module_l2_switch()
#define INGRESS_MODULE_2 module_simple_nat()
#define INGRESS_MODULE_3 module_vlan()
#define INGRESS_MODULE_4 module_l3_switch()
#define INGRESS_MODULE_5 module_simple_acl()
#define INGRESS_MODULE_6 module_simple_qos()


#endif
