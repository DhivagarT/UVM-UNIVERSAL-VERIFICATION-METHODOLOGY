import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)
  
   rand bit rst;
  rand bit d;
  bit q;
  
  function new(string name="transaction");
    super.new(name);
    
  endfunction
  
endclass
