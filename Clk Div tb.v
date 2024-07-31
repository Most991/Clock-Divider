`timescale 1ns/1ps

module clk_div_tb();
  
reg ref_clk_tb;
reg rst_tb;
reg i_clk_en_tb;
reg [7:0] div_ratio_tb;
wire o_div_clk_tb;  

always #5 ref_clk_tb = ~ref_clk_tb;

initial
begin
  rst_tb = 0;
  i_clk_en_tb =0;
  ref_clk_tb =1;
  div_ratio_tb = 10;
  #10
  rst_tb = 1;
  #20
  i_clk_en_tb = 1;
  #400
  
  $stop;
end  


clk_div DUT(
.ref_clk(ref_clk_tb),
.rst(rst_tb),
.i_clk_en(i_clk_en_tb),
.div_ratio(div_ratio_tb),
.o_div_clk(o_div_clk_tb)
);

endmodule
  
