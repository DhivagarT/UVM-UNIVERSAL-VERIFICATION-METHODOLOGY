import uvm_pkg::*;
`include "uvm_macros.svh"

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  monitor mon;
  sequencer seqr;
  driver drv;
  
  function new(string name="agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    mon=monitor::type_id::create("mon",this);
    drv=driver::type_id::create("drv",this);
    seqr=sequencer::type_id::create("seqr",this);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    drv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
endclass
