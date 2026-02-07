import uvm_pkg::*;
`include "uvm_macros.svh"
`include "interface.sv"
`include "test.sv"

module top;
  
  intf vif();
  
  d_ff dut(.clk(vif.clk),
          .rst(vif.rst),
          .d(vif.d),
          .q(vif.q)
        );
  
  initial begin    
    uvm_config_db#(virtual intf)::set(null,"*","vif",vif);   
    run_test ("test");
  end
//   initial vif.clk=0;
  always #5 vif.clk=~vif.clk;
  
  initial begin    
    $dumpfile("my_uvm.vcd");
    $dumpvars;
    vif.clk=0; 
    #300;    
    $finish;   
  end
  
endmodule
