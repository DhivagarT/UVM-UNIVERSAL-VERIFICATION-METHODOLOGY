import uvm_pkg::*;
`include "uvm_macros.svh"

//factory registration
class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  
  //virtual interface
  virtual add_if vif;
    
   //object creation
    seq_item mon_item;
  
  // analysis port
  uvm_analysis_port #(seq_item) mon_ap;

   //default constructor
  function new(string name = "monitor",uvm_component parent=null);
    super.new(name,parent);
    mon_item=new("mon_ap");
  endfunction
  
//phases
    
    //BUILD_PHASE
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db #(virtual add_if)::get(this,"","vif",vif))
        `uvm_info(get_type_name(),"build_phase in monitor is wrong",UVM_MEDIUM);
      mon_ap=new("mon_ap",this);
      
    endfunction
      
      //RUN_PHASE
      virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(),"run_phase in monitor is started",UVM_MEDIUM); 
       
          forever begin 
            #5
            mon_item=seq_item::type_id::create("mon_item",this);
          mon_item.a=vif.a;
          mon_item.b=vif.b;
          mon_item.c=vif.c;
         
          mon_item.sum=vif.sum;
          mon_item.carry=vif.carry;
          mon_item.print();
          
          
          `uvm_info(get_type_name(),$sformatf("a=%d b=%d c=%d sum=%d carry=%d ",mon_item.a,mon_item.b,mon_item.c,mon_item.sum,mon_item.carry),UVM_MEDIUM);
                    
       // analysis port write
                    mon_ap.write(mon_item);
           end
      endtask   
endclass

