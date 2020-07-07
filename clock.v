// `timescale 1s / 1s
module clock_gen(clk);
output reg clk ; 

initial
begin
clk = 0;
end

always
begin
#1 clk=~clk ;
//#1 clk =0 ; 
end

endmodule

///3125_10fs


module clock ();

wire clk;
clock_gen c (clk);
endmodule
