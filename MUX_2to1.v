
module Mux2to1_ir (in1 , in2 , sel , out);

input [4:0]in1, in2 ;
input sel ;

output reg [4:0] out ;

always @ (in1 , in2 , sel)
case (sel)
0 : out <= in1;
1 : out <= in2;

endcase


endmodule

module Mux2to1_alu (in1 , in2 , sel , out);

input [31:0]in1, in2 ;
input  sel ;

output reg [31:0] out ;

always @ (in1 , in2 , sel)
case (sel)
0 : out <= in1;
1 : out <= in2;

endcase


endmodule


module Mux3to1_31bit (in1 , in2 , in3, in4 ,sel , out);

input [31:0]in1, in2,in3,in4 ;
input [1:0] sel ;

output reg [31:0] out ;

always @ (in1 , in2 , in3 , in4 , sel) 
case (sel)
2'b00 : out <= in1;
2'b01 : out <= in2;
2'b10 : out <= in3;
2'b11 : out <= in4;

endcase


endmodule







module Mux3to1_5bit (in1 , in2 ,in3, sel , out);

input [4:0]in1, in2, in3 ;
input [1:0] sel ;

output reg [4:0] out ;

always @ (in1 , in2 , in3 , sel)
case (sel)
2'b00 : out <= in1;
2'b01 : out <= in2;
2'b10 : out <= in3;

endcase
endmodule









