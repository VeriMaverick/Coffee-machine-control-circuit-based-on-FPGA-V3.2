module Selector(
Selector_en,
Selector_sel,
Selector_out
);

input	Selector_en;

input	Selector_sel;

output [2:0] Selector_out;

reg [2:0] Selector_out;

always @ (Selector_en , Selector_sel)
begin 
	if(Selector_en)
		begin
			if(Selector_sel)
				Selector_out = 3'b101;
			else if(!Selector_sel)
				Selector_out = 3'b001;
			else 
				Selector_out = 3'b000;
		end
	else
		Selector_out = 3'b000;
end 

endmodule 