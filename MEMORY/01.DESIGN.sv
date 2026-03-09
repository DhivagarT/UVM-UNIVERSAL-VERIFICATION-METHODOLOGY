module memory(input clk,
              input [7:0]data_in,
              input [3:0]addr,
             input wr_enb,
              output reg[7:0]data_out);
  
  reg [7:0]mem[3:0];
  
  always_ff@(posedge clk)begin
    if(wr_enb)
      mem[addr[3:0]]<=data_in;
        
    data_out<=mem[addr[3:0]];
   
  end
  
endmodule
