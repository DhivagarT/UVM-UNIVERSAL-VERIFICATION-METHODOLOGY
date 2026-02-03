import uvm_pkg::*;
`include "uvm_macros.svh"

//factory registration
class seq_item extends uvm_sequence_item;
  rand logic a, b, c ;
  bit sum,carry;

  //field macros 
  `uvm_object_utils_begin(seq_item)
    `uvm_field_int(a,UVM_ALL_ON)
    `uvm_field_int(b,UVM_ALL_ON)
    `uvm_field_int(c,UVM_ALL_ON)
  `uvm_field_int(sum,UVM_ALL_ON)
  `uvm_field_int(carry,UVM_ALL_ON)
  
  `uvm_object_utils_end
  

  //new constructor
  function new(string name = "seq_item");
    super.new(name);
  endfunction

endclass

