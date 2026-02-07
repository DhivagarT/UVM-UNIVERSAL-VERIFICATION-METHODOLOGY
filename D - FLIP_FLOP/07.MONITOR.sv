import uvm_pkg::*;
`include "uvm_macros.svh"

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  uvm_analysis_port#(transaction) mon_ap;
  virtual intf vif;
  transaction trans;
  
  function new(string name="monitor",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info(get_type_name(),"MONITOR CONSTRUCTOR",UVM_MEDIUM)
    
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon_ap=new("mon_ap",this);
    
    if(!uvm_config_db#(virtual intf)::get(this,"MONITOR ","vif",vif))begin
      `uvm_fatal(get_type_name(),"BUILD PHASE FOR MONITOR IS WRONG")
    end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
    trans=transaction::type_id::create("trans");
    
    wait(!vif.rst);
    @(posedge vif.clk);
    trans.rst=vif.rst;
    trans.d=vif.d;
    @(posedge vif.clk);
    trans.q=vif.q;
    
    mon_ap.write(trans);
    end
    
  endtask
endclass
  
    
    
    
    
    
