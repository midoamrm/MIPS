module mips(DMA_data,DMA_Address,HLDA,HLD,request_to_dma);

wire [31:0]con_pcin;

  
//reg [31:0] pcin = 32'd0;
wire con_clk_pc ;
wire [31:0] con_pc_ins , con_ir , con_pcout4;

 
wire [5:0]  con_op , con_funct ;     // 6 bits 
wire [4:0]  con_rs , con_rt , con_rd ;   // 5 bits 
wire [15:0]  con_first_16  ;     // 16 bits
wire [25:0] con_first_26 ;
wire [31:0] con_first_32 ;

wire [1:0]   con_ALUOp;
wire [1:0] con_MemtoReg ,con_RegDst ;
wire  con_Branch, con_MemRead, con_MemWrite,con_ALUSrc, con_RegWrite,con_Jump , con_jr,memwrite,memread,io1_write,io1_read,io2_write,io2_read,HAL;
wire [3:0] con_ALUControl;

wire [4:0] con_mux1_rf ;
wire [31:0] con_data1 , con_data2, con_writedata ;
wire [31:0] con_data2_mem;
wire con_zero_flag;
wire [31:0] con_result ; 
wire [31:0] con_result_2;

wire [31:0] con_mux_alu;

wire [31:0] con_readData, con_address, con_writeData_dm;

wire [31:0] con_sll_adder, con_adder_out  ;
wire mux_4_sel ;
wire [31:0] mux_4_out  ;

wire [31:0] con_fulladdress ;
wire [31:0] mux_5_out  ;

reg [4:0] ra = 31 ;
wire [4:0] con_shamt ;
wire [31:0] con_sll_result ;
wire move_selector;
wire [15:0] move_data; 
wire IOrequest;
output request_to_dma;
/////////////////////////////////////////////////////
output wire[15:0]DMA_data,DMA_Address;
output HLDA;
input HLD;

//////////////////////////////////////////////////////

clock_gen cg(con_clk_pc);
program_counter pc(con_clk_pc,con_pcin,con_pc_ins,con_pcout4,con_ir[31:26],move_data,IOrequest);

instruction_memory im(con_pc_ins,con_ir );
instruction_reg i_r(con_ir, con_op ,con_rs , con_rt , con_rd, con_first_16 ,con_first_26 ,con_shamt ,con_funct,move_data  );

ALU_Control alu_control (HAL,con_clk_pc,con_op ,con_funct,
                         con_MemtoReg, con_Branch, con_MemRead, con_RegDst ,con_MemWrite,  con_ALUSrc, con_RegWrite,con_Jump,con_jr,
                         con_ALUOp, con_ALUControl,move_selector);



sign_extend sx( con_first_16 , con_first_32);
Mux2to1_alu mux_2(con_data2 , con_first_32 , con_ALUSrc , con_mux_alu);


//Mux2to1_ir mux_1 (con_rt , con_rd, con_RegDst , con_mux1_rf);

Mux3to1_5bit mux_1_1(con_rt , con_rd ,ra, con_RegDst , con_mux1_rf); /// writeregister >> con_mux_rf


resfile rf(con_rs, con_rt,con_mux1_rf, con_writedata, con_RegWrite, con_data1,con_data2,con_data2_mem,con_clk_pc);
ALU alu (con_data1,con_mux_alu,con_ALUControl, con_zero_flag, con_result,con_result_2);

control_signal_mux control_mux(memwrite,memread,io1_write,io1_read,io2_write,io2_read,con_result,con_MemWrite,con_MemRead,con_clk_pc);
////////////////////////////////
DMA_registers_data dma_controller(con_ir,con_clk_pc,con_ir[31:26],move_data,DMA_data,DMA_Address);

///////////////////////////////
dataMemory dm (con_readData , con_result ,con_data2_mem,memread,memwrite,HLDA);
io1 myio1(IOrequest,con_clk_pc,con_readData, con_result ,con_data2_mem,io1_read,io1_write,HLDA,request_to_dma);

//Mux2to1_alu mux_3 (con_result_2, con_readData, con_MemtoReg, con_writedata );

SLL_32 sll_32 (con_first_32 , con_sll_adder);
adder add (con_sll_adder , con_pcout4 , con_adder_out );
Mux2to1_alu mux_4 (con_pcout4 ,con_adder_out, mux_4_sel , mux_4_out);
And myand (con_Branch , con_zero_flag , mux_4_sel );

jumbFullAddress j(con_first_26  ,con_pcout4 , con_fulladdress);
Mux2to1_alu mux_5 (mux_4_out ,con_fulladdress,con_Jump ,mux_5_out); // mux b4 pc


Sll_Generic sll_generic (con_shamt , con_data2 , con_sll_result);
Mux3to1_31bit mux_3_3 (con_result_2 , con_readData , con_pc_ins ,con_sll_result, con_MemtoReg , con_writedata);


Mux2to1_alu mux_6 (mux_5_out , con_result ,  con_jr , con_pcin); // jr mux




//////////////////////////////////////////////////////////////////////////////////////////



endmodule