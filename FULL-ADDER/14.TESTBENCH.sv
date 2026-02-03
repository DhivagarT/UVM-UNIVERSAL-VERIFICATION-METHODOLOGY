`include "uvm_macros.svh"
`include "test.sv"
`include "interface.sv"
import uvm_pkg::*;


module tb_top();
  logic valid;
  add_if vif();
 
  
  adder DUT(.a(vif.a),.b(vif.b),.c(vif.c),.sum(vif.sum),.carry(vif.carry));
  
  initial begin
    // set interface in config_db
    uvm_config_db #(virtual add_if)::set(uvm_root::get(), "*", "vif", vif);
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  initial begin
    
    run_test("test");
  end
endmodule
