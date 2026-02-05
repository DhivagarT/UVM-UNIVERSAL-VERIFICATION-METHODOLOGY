interface intf();
  logic clk;
  logic rst;
  logic din;
  logic qout;
  
//   modport dut(input clk,rst,din,output dout);
  clocking cb@(posedge clk);
    input qout;
    output rst,din;
  endclocking
  
endinterface
