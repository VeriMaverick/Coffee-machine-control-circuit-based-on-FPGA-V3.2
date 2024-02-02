module Adder(
 Adder_In1,
 Adder_In2,
 Adder_Result,
);

input  [2:0] Adder_In1;
input  [2:0] Adder_In2;

output  [2:0] Adder_Result;//计算结果

assign  Adder_Result = Adder_In1 + Adder_In2 ;

endmodule 