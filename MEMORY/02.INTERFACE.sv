interface intf();
  
  logic clk;
  logic [3:0]addr;
  logic [7:0]data_in;
  logic [7:0]data_out;
  logic wr_enb;
  
  clocking cb_drv@(negedge clk);
    default input#1 output#2;
    output addr,data_in,wr_enb;
  endclocking
  
  clocking cb_mon@(posedge clk);
    default input #1;
    input addr,data_in,wr_enb;
  endclocking
  
endinterface
