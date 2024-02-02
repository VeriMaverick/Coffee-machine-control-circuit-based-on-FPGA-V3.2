module Counter (
Counter_clock,
Counter_rst_n,
Counter_LD,
Counter_EN,
Counter_UD,
Counter_pre_value,
Counter_cnt_value
);

input Counter_clock;
input Counter_rst_n;
input Counter_LD;
input Counter_EN;
input Counter_UD;
input [2:0] Counter_pre_value;

output [2:0] Counter_cnt_value;

reg [2:0] Counter_cnt_value;

always @ (posedge Counter_clock , negedge Counter_rst_n)
begin
   if(!Counter_rst_n) 
		begin
			Counter_cnt_value <= 3'b000;
		end
	else if(Counter_LD)        //1  加载预值
		begin
			Counter_cnt_value <= Counter_pre_value;
		end
	else if(Counter_EN)
		begin
			if(Counter_UD)			//1  下行计数open
				begin
					Counter_cnt_value <= Counter_cnt_value - 3'b001;
				end
			else 
				begin
					Counter_cnt_value <= Counter_cnt_value ;
				end
		end
	else
		begin
			Counter_cnt_value <= Counter_cnt_value;
		end
end
endmodule  