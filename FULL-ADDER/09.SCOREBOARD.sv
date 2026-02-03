import uvm_pkg::*;
`include "uvm_macros.svh"


//factory registration
class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  
  //item_queue
  //seq_item i_queue[$];
  
  
  //import creation
  uvm_analysis_imp #(seq_item, scoreboard) scb_port;
 

   //default constructor
  function new(string name = "scoreboard",uvm_component parent=null);
    super.new(name,parent);
    scb_port=new("scb_port",this);
   endfunction  
  
    //BUILD_PHASE
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    endfunction
  
  
  //writing items in item_queue
  function void write(seq_item scb_item);
  
         
          if(((scb_item.a^scb_item.b^scb_item.c)==scb_item.sum)||((scb_item.a&scb_item.b)|(scb_item.b&scb_item.c)|(scb_item.a&scb_item.c))==scb_item.carry)
            `uvm_info(get_type_name(),$sformatf("matched a=%d,b=%d,c=%d,sum=%d,carry=%d",scb_item.a,scb_item.b,scb_item.c,scb_item.sum,scb_item.carry),UVM_MEDIUM)
            
            else `uvm_info(get_type_name(),$sformatf("mismatched a=%d,b=%d,c=%d,sum=%d,carry=%d",scb_item.a,scb_item.b,scb_item.c,scb_item.sum,scb_item.carry),UVM_MEDIUM)
        
            endfunction
      
      
endclass

