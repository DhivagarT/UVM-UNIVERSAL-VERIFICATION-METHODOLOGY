module counter(input clk,rst,enb,output reg[2:0]count);
  
  always_ff@(posedge clk)begin
    if(rst)
      count<=3'b000;
    else if(enb)begin
      count<=count+1'b1;
    end else
      count<=count-1'b1;
  end
endmodule
