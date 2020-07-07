
module ALU (data1,data2,control,zero_flag,result,result_2);
input  [31:0] data1,data2;
input  [3:0] control;
//input clk;
output reg [31:0] result, result_2;
output reg zero_flag; 

always @(data1 or data2 or control)
begin

if(control == 4'b0000)
result = data1 & data2;
else if (control == 4'b0001)
result = data1 | data2;
else if (control == 4'b0010)
result = data1 + data2;
else if (control == 4'b0110)
result = data1 - data2;
else if(control == 4'b0011)
result = data1 + 4 ;
//else if (control == 4'b1110)  // sll
//result = data2 << data1;

else if (control == 4'b0111)
begin
if(data1 < data2)
result = 1;
else 
result = 0;
end
else if (control == 4'b1100)
result = ~(data1 | data2);
else result = 32'h xxxxxxxx;

if(!(data1-data2))
zero_flag=1;
else zero_flag = 0;

assign result_2 = result;
end

endmodule

