import uvm_pkg::*;
`include "uvm_macros.svh"

//factory registration
class seq extends uvm_sequence #(seq_item);
  int count=100;
  seq_item req;
  `uvm_object_utils(seq)

  //default constructor
  function new(string name = "seq_item");
    super.new(name);
    req=new();
  endfunction
  
//task
  virtual task body();
    repeat(count) begin
      `uvm_do(req);
    end
    `uvm_info(get_type_name(),"sequence is started",UVM_MEDIUM)
  endtask
    
    
endclass

