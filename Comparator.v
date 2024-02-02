module Comparator(
Comparator_In,
Comparator_Less_3,
Comparator_Eql_3,
Comparator_Grt_3
);
  
input [2:0] Comparator_In;
output Comparator_Less_3;
output Comparator_Eql_3;
output Comparator_Grt_3;

reg Comparator_Less_3;
reg Comparator_Eql_3;
reg Comparator_Grt_3;

parameter Price=3'b011;

always @ (*)
begin
	if(Comparator_In < Price)
		begin
			Comparator_Less_3 =1'b1;
			Comparator_Eql_3  =0;
			Comparator_Grt_3  =0;
		end
	else if(Comparator_In == Price)
		begin
			Comparator_Less_3 =0;
			Comparator_Eql_3  =1'b1;
			Comparator_Grt_3  =0;
		end
	else if(Comparator_In > Price)
		begin
			Comparator_Less_3 =0;
			Comparator_Eql_3  =0;
			Comparator_Grt_3  =1'b1;
		end
	else 
		begin
			Comparator_Less_3 =0;
			Comparator_Eql_3  =0;
			Comparator_Grt_3  =0;
		end
end
endmodule 