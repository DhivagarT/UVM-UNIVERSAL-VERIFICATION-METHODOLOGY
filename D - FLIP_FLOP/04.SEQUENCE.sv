import uvm_pkg::*;
`include "uvm_macros.svh"

class seq extends uvm_sequence#(transaction);
  `uvm_object_utils(seq)
  
  function new(string name="seq");
    super.new(name);
  endfunction
  
//   task body();
//     transaction trans;
   
//     repeat(10)begin
//        trans=transaction::type_id::create("trans");
//       `uvm_do(trans)
//     end
//   endtask
  
   task body();
    transaction tr;
    repeat (5) begin
      tr = transaction::type_id::create("tr");
      start_item(tr);
      assert(tr.randomize());
      finish_item(tr);
    end
  endtask
endclass
