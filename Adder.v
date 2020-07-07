
module adder (in1 , in2 , out );

input [31:0] in1,in2 ;
output reg [31:0] out ;

always @ (in1 or in2)
begin 
 out = in1 + in2 ;
end
endmodule



module And (in1 , in2 , out );

input  in1,in2 ;
output reg out ;

always @ (in1 or in2)
begin 
 out = in1 & in2 ;
end

endmodule 