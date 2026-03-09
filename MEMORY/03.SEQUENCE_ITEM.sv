import uvm_pkg::*;
`include "uvm_macros.svh"

class transaction extends uvm_sequence_item;
  `uvm_object_utils(transaction)
 
  
  rand bit [7:0]data_in;
  rand bit [3:0]addr;
  rand bit wr_enb;
  bit [7:0]data_out;
  
//   constraint c2{data_in inside{[1:10],[20:65]};}
  
  function new(string name="transaction");
    super.new(name);
  endfunction
  
endclass
