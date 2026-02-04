`ifndef INTERFACE_SV
`define INTERFACE_SV

interface intf();
  logic clk;
  logic rst;
  logic enb;
  logic [2:0]count;
  
//   clocking cb@(posedge clk);
//     input count;
//     output rst,enb;
//   endclocking
    
endinterface

`endif
