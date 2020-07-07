
module sign_extend ( oldwire , newwire);


input [15:0]oldwire ;



output reg [31:0] newwire ;




  always @(oldwire)
    begin
		assign newwire = {{16{oldwire[15]}}, oldwire};

    end


endmodule
