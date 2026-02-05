module d_ff(input clk,rst,din,output reg qout);
  
  always_ff@(posedge clk)begin
    if(rst)
      qout<=1'b0;
    else
      qout<=din;
  end
endmodule
