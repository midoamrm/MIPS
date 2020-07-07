module ALU_Control (input HAL,input clk,input [5:0] op ,funct,
                    output reg [1:0] MemtoReg, output reg Branch, MemRead,output reg [1:0] RegDst ,output reg MemWrite,  ALUSrc, RegWrite,Jump,Jr, // memtoreg kant 2 bits
                    output reg [1:0] ALUOp, output reg [3:0] ALUControl,output reg move_sel);

always @ (op,funct)
begin
Jr<=0;
move_sel=0;
if (op == 0)  // R-type
begin 
RegDst <= 1;
if (funct != 8)
begin
  RegWrite <= 1;Jr <= 0 ;
end
else
 begin
RegWrite <=0;Jr <= 1;
end

ALUSrc <= 0;
MemtoReg <= 0;
MemRead <= 0;
MemWrite <= 0;
Branch <=0;
Jump <= 0;

ALUOp <= 2'b10 ;  // R   
            if (funct == 32 )
              begin
                ALUControl = 4'b0010 ; // (+) add
               end 
            else if (funct == 34 )
              begin
                ALUControl = 4'b0110 ; // (-) sub
               end

            else if (funct == 36)
              begin
                 ALUControl = 4'b0000 ; // and
               end

            else if (funct == 37)
              begin
                ALUControl = 4'b0001 ; // or
               end

            else if (funct == 42)
              begin
                 ALUControl = 4'b0111 ; // (-) slt
               end

            else if (funct == 8)  
              begin
                 ALUControl = 4'b0011 ; // JR
                
               end

           else if (funct == 0)  
              begin
                 ALUControl = 4'b1110 ; // sll
                 MemtoReg <= 2'b11;
               end



end

else if (op == 8)  // addi
begin
RegDst <= 0;
RegWrite <= 1;
ALUSrc <= 1;
MemtoReg <= 0;
MemRead <= 0;
MemWrite <= 0;
Branch <=0;
Jump <= 0;


ALUOp <= 2'b0 ; // Addition
ALUControl <= 4'b0010 ;

end


else if (op == 13)  // ori
begin
RegDst <= 0;
RegWrite <= 1;
ALUSrc <= 1;
MemtoReg <= 0;
MemRead <= 0;
MemWrite <= 0;
Branch <=0;
Jump <= 0;

ALUOp <= 2'b11 ; 
ALUControl <= 4'b0001 ;

end

else if (op == 35)  // lw
begin
RegDst <= 0;
RegWrite <= 1;
ALUSrc <= 1;
MemtoReg <= 1;
MemRead <= 1;
MemWrite <= 0;
Branch <=0;
Jump <= 0;

ALUOp <= 2'b0  ;// Addition
ALUControl <= 4'b0010 ;
end
    

else if (op == 43)  // sw
begin
RegDst <= 1'bx;
RegWrite <= 0;
ALUSrc <= 1;
MemtoReg <= 1'bx;
MemRead <= 0;
MemWrite <= 1;
Branch <=0;
Jump <= 0;

ALUOp <= 2'b0 ; // Addition
ALUControl <= 4'b0010 ;
end


else if (op == 4)  // beq
begin
RegDst <= 1'bx;
RegWrite <= 0;
ALUSrc <= 0;
MemtoReg <= 0;
MemRead <= 0;
MemWrite <= 0;
Branch <=1;
Jump <= 0;

ALUOp <= 2'b01 ; // Subtraction
ALUControl <= 4'b0110 ;
end

else if (op == 2)  // j
begin
RegDst <= 1'bx;
RegWrite <= 0;
ALUSrc <= 1'bx;
MemtoReg <= 1'bx;
MemRead <= 0;
MemWrite <= 0;
Branch <=0;
Jump <= 1;

ALUOp <= 2'bxx ;
end



else if (op == 3)  // jal
begin
RegDst <= 2'b10;
RegWrite <= 1;
ALUSrc <= 1'bx;
MemtoReg <= 2'b10;
MemRead <= 0;
MemWrite <= 0;
Branch <=0;
Jump <= 1;

ALUOp <= 2'bxx ;
end

else if (op ==56)  // move number of elements
begin
RegDst <= 0;
RegWrite <= 0;
ALUSrc <= 1;
MemtoReg <= 0;
MemRead <= 0;
MemWrite <= 0;
Branch <=0;
Jump <= 0;
move_sel<=1;
end
else if (op ==57 )  // move from address ***
begin
RegDst <= 0;
RegWrite <= 0;
ALUSrc <= 1;
MemtoReg <= 0;
MemRead <= 0;
MemWrite <= 0;
Branch <=0;
Jump <= 0;
move_sel<=1;
end
else if (op == 59)  // move to address ***
begin
RegDst <= 0;
RegWrite <= 0;
ALUSrc <= 1;
MemtoReg <= 0;
MemRead <= 0;
MemWrite <= 0;
Branch <=0;
Jump <= 0;
move_sel<=1;
end


//$monitor ("%b %b %b %b %b %b %b %b",RegDst,RegWrite,ALUSrc,MemtoReg,MemRead,Branch,Jump, ALUOp, ALUControl);

end
endmodule

