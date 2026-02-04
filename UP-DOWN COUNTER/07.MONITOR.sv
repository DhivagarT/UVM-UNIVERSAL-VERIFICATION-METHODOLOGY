`ifndef MONITOR_SV
`define MONITOR_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

// `include "sequence_item.sv"
// `include "interface.sv"

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  virtual intf vif;
  uvm_analysis_port #(transaction)ap;
  
  function new(string name="monitor",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
 function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Get virtual interface from config DB
    if (!uvm_config_db#(virtual intf)::get(this, "", "vif", vif))
      `uvm_fatal("MON", "Virtual interface not found!")

    // Create analysis port
    ap = new("ap", this);
  endfunction
  
    
 task run_phase(uvm_phase phase);
  forever begin
    @(posedge vif.clk);

    if (!vif.rst && vif.enb) begin
      transaction trans;
      trans = transaction::type_id::create("trans", this);

      trans.enb   = vif.enb;
      trans.rst   = vif.rst;
      trans.count = vif.count; 

      ap.write(trans);
      trans.print();

//       `uvm_info("MON",
//         $sformatf("MONITORED: %s", trans.convert2string()),
//         UVM_LOW)
    end
  end
endtask

endclass
`endif
    
    
    
