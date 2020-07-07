
module Sll_Generic (shamt , data2 , result); // sll r format 

input [4:0] shamt;
input [31:0] data2;
output [31:0] result ;


assign result = data2 << shamt ;


endmodule

