module DMA_registers_data(IR,clk,op_code,move_data,data_bus,Address_bus);
input[15:0]move_data;
input[5:0]op_code;
input clk;
input [31:0] IR ; 
integer flag;
integer memory;
output reg[15:0]data_bus,Address_bus;
initial begin flag=0;memory=0; end
always@(IR)
begin
if(op_code==56)
begin
data_bus=IR[15:0]; //2 cycles to write in word count 
Address_bus=1;
end
else if(op_code==57)
begin
if(IR[15:0]>8191*4)//prephiral to .....
begin
if(flag==0)
begin
Address_bus=7; //command register address
data_bus=32'h00000080;
flag=flag+1;
end
else if(flag==1)
begin
Address_bus=11; //mask register address
data_bus=32'h00000000;
flag=flag+1;
end
else if(flag==2)
begin
Address_bus=10; //mode register address
data_bus=32'h00000008;//read from this channel (IO to mem)
flag=flag+1;
end
else if(flag==3)
begin
Address_bus=12; //request register address
data_bus=32'h00000000;
flag=0;
end
end
else if(IR[15:0]<=8191*4)//memory to ....
begin
memory=1;   //memory source indication
if(flag==0)
begin
data_bus=IR[15:0]; // base Address data
Address_bus=0;	//baseAddress address 
flag=flag+1;
end
else if(flag==1)
begin
Address_bus=11; //mask register address
data_bus=32'h00000000;
flag=flag+1;
end
else if(flag==2)
begin
Address_bus=12; //request register address
data_bus=32'h00000000;
flag=0;
end
end
end
else if (op_code==59)
begin
if(IR[15:0]<=4*8191 && memory)//memory to memory
begin
if(flag==0)
begin
Address_bus=13;//destination baseaddress register
data_bus=IR[15:0];
flag=flag+1;
end
else if(flag==1)
begin
Address_bus=7;//command register
data_bus=32'h00000001; // mem to mem enable
flag=flag+1;
end
else if(flag==2)
begin
Address_bus=12; //request register address
data_bus=32'h00000000;
flag=0;
memory=0;
end
end
else if(IR[15:0]>=4*8191 && memory)//memory to IO
begin
if(flag==0)
begin
Address_bus=10; //mode register address
data_bus=32'h00000004;//write to this channel (mem to io)
flag=flag+1;
end
else if(flag==1)
begin
Address_bus=7; //command register address
data_bus=32'h00000000;//mem to mem disable
flag=0;
memory=0;
end
end
else if(IR[15:0]<=4*8191 && !memory)//IO to memory
begin
memory=0;
data_bus=IR[15:0]; // base Address data
Address_bus=0;	//baseAddress address 
end

end

end


endmodule




module tb_rrrr();
reg [5:0] op_code;
reg [15:0] move_data ;
wire [15:0] data_bus , address_bus;
reg clk;
DMA_registers_data my(clk,op_code,move_data,data_bus,address_bus);



endmodule





















