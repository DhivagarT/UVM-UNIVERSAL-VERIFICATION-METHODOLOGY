//Transaction class

`ifndef SEQUENCE_ITEM_SV
`define SEQUENCE_ITEM_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
  rand bit enb;
  rand bit rst;
  bit [2:0]count;
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(rst,UVM_ALL_ON)
  `uvm_field_int(enb,UVM_ALL_ON)
  `uvm_field_int(count,UVM_ALL_ON)
  `uvm_object_utils_end

  
  function new(string name="transaction");
    super.new(name);
  endfunction
  
//   function string convert2string();
//     $sformatf("ENB=%d | COUNT=%d",enb,count);
//   endfunction
  
  constraint c1{enb dist{0:=5,1:=5};}
  constraint c2{rst dist{0:=95,1:=5};}
endclass

`endif
  
