
`ifndef AGENT_SV
`define AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
// `include "uvm_monitor.sv"
// `include "uvm_driver.sv"
// `include "uvm_sequence_item.sv"
// `include "uvm_sequencer.sv"

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  sequencer seqr;
  monitor mon;
  counter_driver drv;
  
  uvm_active_passive_enum is_active;
  virtual intf vif;
  
  function new(string name="agent",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("AGENT", "Agent Created", UVM_MEDIUM)
  endfunction
  
    // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active))
      is_active = UVM_ACTIVE;

    if (is_active == UVM_ACTIVE) begin
      seqr = sequencer::type_id::create("seqr", this);
      drv  = counter_driver::type_id::create("drv",  this);
    end

    mon = monitor::type_id::create("mon", this);

 // Get virtual interface
    if (!uvm_config_db#(virtual intf)::get(this, "", "vif", vif))
      `uvm_fatal("AGENT", "Virtual interface not set")

    // Pass vif via config DB
    if (is_active == UVM_ACTIVE)
      uvm_config_db#(virtual intf)::set(this, "drv", "vif", vif);

    uvm_config_db#(virtual intf)::set(this, "mon", "vif", vif);

    `uvm_info("AGENT", "Agent build_phase complete", UVM_LOW)
  endfunction

  // Connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if(is_active == UVM_ACTIVE)
      drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction

endclass

`endif
    
