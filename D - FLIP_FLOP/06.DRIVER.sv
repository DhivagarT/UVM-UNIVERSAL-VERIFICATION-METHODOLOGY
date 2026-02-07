import uvm_pkg::*;
`include "uvm_macros.svh"

class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)
  
  virtual intf vif;
  transaction trans;
  
  function new(string name="driver",uvm_component parent=null);
    super.new(name,parent);
    
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    if(!uvm_config_db#(virtual intf)::get(this,"","vif",vif))begin
      `uvm_fatal(get_type_name(),"BUILD PHASE FOR DRIVER NOT CREATED")
      
    end
      
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_type_name(),"RUN PHASE IN DRIVER IS STARTED",UVM_MEDIUM)
    forever begin
      trans = transaction::type_id::create("trans");
      seq_item_port.get_next_item(req);
      driver_task(req);
      seq_item_port.item_done();
    end
  endtask
  
  task driver_task(input transaction trans);
    @(posedge vif.clk);
    vif.rst<=trans.rst;
    vif.d<=trans.d;
  endtask
  
endclass
