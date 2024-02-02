module Nixie_tube(
Seg,
Data1
);
input [2:0]Seg;

output Data1;

reg [6:0] Data1;

always @ (Seg)
	begin
		case(Seg)
			3'd0:   begin Data1=7'b1000000;  end
			3'd1:   begin Data1=7'b1111001;  end
         3'd2:   begin Data1=7'b0100100;  end
         3'd3:   begin Data1=7'b0110000;  end
			3'd4:   begin Data1=7'b0011001;  end
			3'd5:   begin Data1=7'b0010010;  end
			3'd6:   begin Data1=7'b0000010;  end
			3'd7:   begin Data1=7'b1111000;  end
			
			default:begin Data1=7'b1111111;  end
		endcase 
	end
endmodule 