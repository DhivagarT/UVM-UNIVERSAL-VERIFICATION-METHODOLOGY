import uvm_pkg::*;
`include "uvm_macros.svh"

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  uvm_analysis_imp#(transaction,scoreboard) scb_ap;
  
  virtual intf vif;
//   transaction trans;
  
  function new(string name="scoreboard",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info(get_type_name(),"SCOREBOARD CONSTRUCTOR",UVM_MEDIUM)
    
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_ap=new("scb_ap",this);
    
    if(!uvm_config_db#(virtual intf)::get(this,"SCOREBOARD ","vif",vif))begin
      `uvm_fatal(get_type_name(),"BUILD PHASE FOR SCOREBOARD IS WRONG")
    end
  endfunction
  
  function void write(transaction trans);
    bit exp_q;
    
    if(trans.rst)
      exp_q=1'b0;
    else
      exp_q=trans.d;
    
    if(exp_q==trans.q)
      `uvm_info("SB",
                $sformatf("---PASS--- RST=%d DIN=%d EXPECCTED Q=%d ACTUAL Q=%d",trans.rst,trans.d,exp_q,trans.q),UVM_MEDIUM)
      
      else
        `uvm_info("SB",
                  $sformatf("---FAIL--- RST=%d DIN=%d EXPECCTED Q=%d ACTUAL Q=%d",trans.rst,trans.d,exp_q,trans.q),UVM_MEDIUM)
        
  endfunction
endclass      
