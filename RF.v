module resfile(read1,read2,writereg,writedata,write,data1,data2,data2_mem,clk);
input[4:0]read1,read2,writereg;
input[31:0]writedata;
input write,clk;
reg[31:0]rf[0:31];
output [31:0] data1,data2, data2_mem; 
integer file ;
integer i;
integer flag=1; 
initial
begin
rf[0] <= 0 ;
 // rs
/*rf[1] <=20 ;  // rt 
rf[2]<= 45 ; 
rf[16]<= 10;
rf[17]<=6 ; //$zero */
end
/////////////////////
assign data1 = rf[read1];
assign data2 = rf[read2];
assign data2_mem = data2;

/*always @(read1,read2)
begin		
 data1 <= rf[read1];
 data2 <= rf[read2];
 data2_mem <= data2; //for mux after data mem
end
*/
always@(posedge clk)
begin
if(flag)
rf[29]=1200;
flag=0;

if (write)
rf[writereg]<=writedata;

file = $fopen("C:\\Users\\Mohammed Emad\\Desktop\\MIPS project\\Printing\\out_rf.txt","w");
for (i = 0; i<32; i=i+1)
begin
//if (i==0) $monitor("hello i am inside the for & rf[16] = %d",rf[16]);
//@(posedge clk);
$fwrite(file,"%b\n",rf[i]);
end
$fclose(file);
end

endmodule

