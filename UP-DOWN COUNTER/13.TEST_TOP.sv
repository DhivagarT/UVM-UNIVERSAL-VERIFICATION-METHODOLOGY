import uvm_pkg::*;
`include "uvm_macros.svh"
`include "test.sv"
`include "interface.sv"

module test_top;

  intf vif();

  counter dut (
    .clk   (vif.clk),
    .rst   (vif.rst),
    .enb   (vif.enb),
    .count (vif.count)
  );

  // Clock generation
  initial begin
    vif.clk = 0;
    forever #5 vif.clk = ~vif.clk;
  end

  // Reset and enable
//   initial begin
//     vif.rst = 1;
//     vif.enb = 0;
//     #20;
//     vif.rst = 0;
//     vif.enb = 1;
//   end

  // Pass interface to UVM
  initial begin
    uvm_config_db #(virtual intf)::set(null, "*", "vif", vif);
    $dumpfile("counter.vcd");
    $dumpvars(0, test_top);
  end

  initial begin
    run_test("test");
  end

endmodule
