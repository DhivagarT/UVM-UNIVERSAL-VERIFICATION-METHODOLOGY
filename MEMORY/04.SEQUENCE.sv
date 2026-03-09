import uvm_pkg::*;
`include "uvm_macros.svh"

class sequ extends uvm_sequence#(transaction);
  `uvm_object_utils(sequ)
  
  function new(string name="sequ");
    super.new(name);
  endfunction
  
  task body();
    transaction trans;
    repeat(15)begin
      trans=transaction::type_id::create("trans");
//       `uvm_do(trans)
      start_item(trans);
      if(trans.randomize())
        `uvm_info("SEQ","RANDOMIZATION COMPLETED",UVM_MEDIUM)
        else
          `uvm_info("SEQ","RANDOMIZATION FAILED",UVM_MEDIUM)
      finish_item(trans);
    end
  endtask
endclass
      
    
