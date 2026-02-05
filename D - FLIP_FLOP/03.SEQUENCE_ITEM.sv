`ifndef SEQUENCE_ITEM
`define SEQUENCE_ITEM

import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
  
  rand bit rst;
  rand bit din;
  bit qout;
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(rst,UVM_ALL_ON)
  `uvm_field_int(din,UVM_ALL_ON)
  `uvm_field_int(qout,UVM_ALL_ON)
  `uvm_object_utils_end
  
  
  function new(string name="transaction");
    super.new(name);
  endfunction
  
  constraint c1{din dist{0:=25,1:=25};}
  
endclass
`endif

  
  
