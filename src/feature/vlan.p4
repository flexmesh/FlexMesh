#ifndef MODULE_VLAN
#define MODULE_VLAN

action vlan_decap() {
	modify_field(ethernet.eth_type, vlan.eth_type);
	remove_header(vlan);
}

action vlan_encap(pcp, cfi, vid) {
	add_header(vlan);
	modify_field(vlan.eth_type, ethernet.eth_type);
	modify_field(vlan.cfi, cfi);
	modify_field(vlan.pcp, pcp);
	modify_field(vlan.vid, vid);
	modify_field(ethernet.eth_type, ETH_TYPE_VLAN);
}

action vlan_block() {
	drop();
}

table port_domain {
	reads {
		standard_metadata.egress_spec : exact;
	}
	actions {
		nop;
		on_miss;
	}
}

table vlan_filter{
	reads {
		vlan.vid : exact;
		standard_metadata.egress_spec : exact;
	}
	actions {
		vlan_block;
		vlan_decap;
	}
}

table vlan_tbl {
	reads {
		ethernet.src_addr : exact;
	}

	actions {
		vlan_encap;
		on_miss;
	}	
}

MODULE_INGRESS(vlan) {
	apply(vlan_tbl) {
		on_miss {
			apply(port_domain) {
				on_miss {
					apply(vlan_filter);
				}
			}
		}
	}
}

#endif