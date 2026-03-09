import uvm_pkg::*;
`include "uvm_macros.svh"

class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)
  
  virtual intf vif;
  
  function new(string name="driver",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(virtual intf)::get(this,"*","vif",vif))begin
      `uvm_fatal(get_type_name(),"BUILD PHASE FOR DRIVER NOT EXECUTED")
    end
    
  endfunction
    transaction req;
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    
    forever begin

      seq_item_port.get_next_item(req);
      driver_t(req);    
    seq_item_port.item_done();
    end
  endtask
      
      virtual task driver_t(transaction t);
          @(vif.cb_drv);
    vif.wr_enb<=t.wr_enb;
    vif.data_in<=t.data_in;
      vif.addr<=t.addr;
      endtask
      
   
endclass

      
