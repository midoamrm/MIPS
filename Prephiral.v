module io1(IOrequest,clk,readData,address,writeData,Read,Write,HAL,request_to_dma);//keyboard 
input[31:0]address;
input [31:0]writeData;
input Read,Write,HAL  ; 
output reg [31:0] readData;
reg [31:0]io1[0:4];
input IOrequest,clk;
output reg request_to_dma;

always@(posedge clk)
begin
if(IOrequest)request_to_dma=1;
else request_to_dma=0;
end

always @(address) 
begin

if(Read == 0 && Write == 1)
begin 
if(HAL != 1)
begin
io1[(address-32768)/4] <= writeData;  // note address calculation
end
else if(HAL)
begin
if(((address-32768)/4)%4 == 0)io1[(address-32768)/4][7:0] <= writeData;
else if(((address-32768)/4)%4 == 1)io1[((address-32768)-1)/4][15:8] <= writeData;
else if(((address-32768)/4)%4 == 2)io1[((address-32768)-2)/4][23:16] <= writeData;
else if(((address-32768)/4)%4 == 3)io1[((address-32768)-3)/4][31:24] <= writeData;
end

end

else if(Read == 1 && Write == 0)
begin
if(HAL != 1)
begin
readData = io1[(address-32768)/4];   // note dividing by 4
end
else if(HAL)
begin
if(((address-32768)/4)%4 == 0)readData=io1[(address-32768)/4][7:0];
else if(((address-32768)/4)%4 == 1)readData=io1[((address-32768)-1)/4][15:8];
else if(((address-32768)/4)%4 == 2)readData=io1[((address-32768)-2)/4][23:16];
else if(((address-32768)/4)%4 == 3)readData=io1[((address-32768)-3)/4][31:24];
end
end

else 
begin

readData = 32'hxxxxxxxx;
end
end
endmodule




