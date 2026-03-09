import uvm_pkg::*;
`include "uvm_macros.svh"

class environment extends uvm_env;
  `uvm_component_utils(environment)
  
  agent ag;
  coverage cvg;
  scoreboard scb;
  
  function new(string name="environment",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    ag=agent::type_id::create("ag",this);
    cvg=coverage::type_id::create("cvg",this);
    scb=scoreboard::type_id::create("scb",this);
    
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    ag.mon.mon_ap.connect(scb.scb_ap);
    ag.mon.mon_ap.connect(cvg.analysis_export);
    
  endfunction
endclass
