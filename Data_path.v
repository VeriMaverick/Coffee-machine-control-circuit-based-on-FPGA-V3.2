module Data_path(
Data_path_clock,
Data_path_rst_n,
Data_path_sel_en,
Data_path_sel_sel,
Data_path_cnt_ld,
Data_path_cnt_en,
Data_path_cnt_ud,
Data_path_com_Less_3,
Data_path_com_Eql_3,
Data_path_com_Grt_3,
Data1
);

input Data_path_clock;
input Data_path_rst_n;
    
input Data_path_sel_en;
input Data_path_sel_sel;
 
input Data_path_cnt_ld;
input Data_path_cnt_en;
input Data_path_cnt_ud; 

output Data_path_com_Less_3;
output Data_path_com_Eql_3;
output Data_path_com_Grt_3;

output [6:0] Data1;

wire [2:0] Sel_to_Add;
wire [2:0] Add_to_Cnt;
wire [2:0] Cnt_to_Com;

//实例化选择器
Selector U0(
.Selector_en(Data_path_sel_en),
.Selector_sel(Data_path_sel_sel),
.Selector_out(Sel_to_Add)
);

//实例化全加器
Adder    U1(
.Adder_In1(Sel_to_Add),
.Adder_In2(Cnt_to_Com),
.Adder_Result(Add_to_Cnt)
);

//实例化计数器
Counter  U2(
.Counter_clock(Data_path_clock),
.Counter_rst_n(Data_path_rst_n),
.Counter_LD(Data_path_cnt_ld),
.Counter_EN(Data_path_cnt_en),
.Counter_UD(Data_path_cnt_ud),
.Counter_pre_value(Add_to_Cnt),
.Counter_cnt_value(Cnt_to_Com)
);
//实例化比较器
Comparator U3(
.Comparator_In(Cnt_to_Com),
.Comparator_Less_3(Data_path_com_Less_3),
.Comparator_Eql_3(Data_path_com_Eql_3),
.Comparator_Grt_3(Data_path_com_Grt_3)
);

Nixie_tube U4(
.Seg(Cnt_to_Com),
.Data1(Data1)
);

endmodule 