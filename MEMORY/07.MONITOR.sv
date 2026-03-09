import uvm_pkg::*;
`include "uvm_macros.svh"

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  virtual intf vif;
  
  uvm_analysis_port#(transaction) mon_ap;
  
  
  function new(string name="monitor",uvm_component parent=null);
    super.new(name,parent);
    
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual intf)::get(this,"*","vif",vif))begin
      `uvm_fatal("MON","BUILD PHASE FOR MONNITOR NOT CREATED")
    end
    
    mon_ap=new("mon_ap",this);
  endfunction
   transaction trans;
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   
    `uvm_info(get_type_name(),"MONITOR START RECIEVING",UVM_MEDIUM)
    repeat(150) begin
      trans=transaction::type_id::create("trans",this);
      
      @(vif.cb_mon);
      trans.wr_enb=vif.wr_enb;
      trans.addr=vif.addr;
      trans.data_in=vif.data_in;
//       @(vif.cb_mon);
      trans.data_out=vif.data_out;
      
      mon_ap.write(trans);
    end
  endtask
endclass
      
