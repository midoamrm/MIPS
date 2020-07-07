
module SLL_26(in , out);

input [25:0]in;
output [31:0]out;

assign out = in*4;

endmodule


module SLL_32(in , out);

input [31:0]in;
output [31:0]out;

assign out = in*4;

endmodule




module jumbFullAddress(in  , pc , fullAddress);

input [25:0]in;
input [31:0]pc;
output [31:0]fullAddress;
wire [31:0]sll_out;

SLL_26 sll(in , sll_out);


assign fullAddress = sll_out | (pc & 32'hf0000000);

endmodule
