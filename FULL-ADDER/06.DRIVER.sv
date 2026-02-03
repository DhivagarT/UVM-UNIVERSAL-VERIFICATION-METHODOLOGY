import uvm_pkg::*;
`include "uvm_macros.svh" 

//factory registration
class driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)
  
  
  //virtual interface
  virtual  add_if vif;
    
   //object creation
    seq_item req;

  //default constructor
  function new(string name = "driver",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
//phases
    
    //BUILD_PHASE
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db #(virtual add_if)::get(this,"","vif",vif))
        `uvm_info(get_type_name(),"build_phase in driver is wrong",UVM_MEDIUM);
    endfunction
      
      //RUN_PHASE
      virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(),"run_phase in driver is started",UVM_MEDIUM); 
        forever begin
          seq_item_port.get_next_item(req);
          drive_item(req);
          seq_item_port.item_done();
        end
      endtask
      
      task drive_item(input seq_item req);
        vif.a<=req.a;
        vif.b<=req.b;
        vif.c<=req.c;
      endtask
    
    
endclass

