
module dataMemory(readData ,  address , writeData , memRead , memWrite);

input[31:0]address; // kant 5
input [31:0]writeData;
input memRead , memWrite  ; 
output reg [31:0] readData;

reg [31:0]memory[0:8191];


initial
begin
    // Loading The Memory
$readmemb ("D:\\3rd Computer\\C.O\\Project/MemmmmFile.txt", memory);  
   
end 



always @(address) 

begin

if(memRead == 0 && memWrite == 1)
begin 

memory[address/4] <= writeData;  // note dividing by 4

end

else if(memRead == 1 && memWrite == 0)
begin

readData = memory[address/4];   // note dividing by 4

end

else 
begin

readData = 32'hxxxxxxxx;

end

end


endmodule
