`ifndef SEQUENCE_SV
`define SEQUENCE_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class seq extends uvm_sequence#(transaction);
  `uvm_object_utils(seq)
  
  function new(string name="seq");
    super.new(name);
  endfunction
  
  task body();
    transaction trans;
    repeat(50)begin
    `uvm_do(trans)
    
//     start_item(trans);
//     assert(trans.randomize());
//     finish_item(trans);
    end
  endtask
  
endclass
`endif
      
      
