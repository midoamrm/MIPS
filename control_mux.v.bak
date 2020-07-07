module control_signal_mux(IOW,memwrite,memread,io1_write,io1_read,io2_write,io2_read,address,write_signal,read_signal,clk);
input clk,write_signal,read_signal;
input [31:0]address;
output reg memwrite,memread,io1_write,io1_read,io2_write,io2_read,IOW;
always@(clk)
begin
if(address>=0 && address<=11)IOW=0; //fill in DMA registers

else if(address>=12 && address<=32764)
begin
memwrite<=write_signal;
memread<=read_signal;
end
else if (address==32768)
begin
io1_write<=write_signal;
io1_read<=read_signal;
end
else if (address==32772)
begin
io2_write<=write_signal;
io2_read<=read_signal;
end
end
endmodule
