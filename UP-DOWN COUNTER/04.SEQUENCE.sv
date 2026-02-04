`ifndef SEQUENCE_SV             //to not repeat the same file many times
`define SEQUENCE_SV            // to define the file

import uvm_pkg::*;                //without this no factory registeration declared
`include "uvm_macros.svh"          //including library to use 

// `include "sequence_item.sv"

class counter_sequence extends uvm_sequence#(transaction);
  `uvm_object_utils(counter_sequence)               //factory_registration
  
  function new(string name="counter_sequence");     //function new constructor
    super.new(name);
  endfunction
  
  task body();                              
    transaction tx;                          //creating handle for the parameterized class
    repeat(10)begin
    `uvm_do(tx)                              //to do randomization automatically
    
    /*
      tx=transaction::type_id::create("tx");   //creating object using create key
      start_item(tx);
      assert(tx.randomize());    
      finish_item(tx);
    */
    end
  endtask
endclass

`endif
