`ifndef SEQUENCER_SV
`define SEQUENCER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

// `include "sequence_item.sv"

class sequencer extends uvm_sequencer#(transaction);
  `uvm_component_utils(sequencer)
  
  function new(string name="sequencer",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info("SEQ","sequencer for build phase is completed",UVM_MEDIUM)
  endfunction
    
endclass
`endif
