module Coffee(
Coffee_Clock,
Coffee_Reset_n,
Coffee_Cup_rdy,
Coffee_Cof_rdy,
Coffee_Coin_1,     //Coin one yuan
Coffee_Coin_5,     //Coin five yuan
Coffee_Place_cup,
Coffee_Inject_cof,
Coffee_LCD_EN,
Coffee_LCD_RW,
Coffee_LCD_RS,
Coffee_LCD_DATA,
Coffee_Refund,
Coffee_Coin_return,
Coffee_Data1
);

//Top level module input and output
input Coffee_Clock;
input Coffee_Reset_n;
input Coffee_Cup_rdy;
input Coffee_Cof_rdy;
input Coffee_Coin_return;
input Coffee_Coin_1;
input Coffee_Coin_5;
output Coffee_Place_cup;
output Coffee_Inject_cof;
output Coffee_Refund;

output Coffee_LCD_EN;
output Coffee_LCD_RW;
output Coffee_LCD_RS;
output [7:0] Coffee_LCD_DATA;
output [6:0] Coffee_Data1;

wire Less_3;
wire Eql_3;
wire Grt_3; 
wire sel_en;
wire sel_sel;
wire Cnt_en;
wire Cnt_ld;
wire Cnt_ud;
wire Cnt_clr;

//实例化数据通道
Data_path    U0(
.Data_path_clock(Coffee_Clock),
.Data_path_rst_n(Cnt_clr),
.Data_path_sel_en(sel_en),
.Data_path_sel_sel(sel_sel),
.Data_path_cnt_ld(Cnt_ld),
.Data_path_cnt_en(Cnt_en),
.Data_path_cnt_ud(Cnt_ud),
.Data_path_com_Less_3(Less_3),
.Data_path_com_Eql_3(Eql_3),
.Data_path_com_Grt_3(Grt_3),
.Data1(Coffee_Data1)
);

//实例化控制单元
Control_unit U1(
.Clock(Coffee_Clock),
.Reset_n(Coffee_Reset_n),
.Coin_1(Coffee_Coin_1),
.Coin_5(Coffee_Coin_5),
.Cup_rdy(Coffee_Cup_rdy),
.Cof_rdy(Coffee_Cof_rdy),
.Place_cup(Coffee_Place_cup),
.Inject_cof(Coffee_Inject_cof),
.Less_3(Less_3),
.Eql_3(Eql_3),
.Grt_3(Grt_3),
.sel_en(sel_en),
.sel_sel(sel_sel),
.Cnt_clr(Cnt_clr),
.Cnt_en(Cnt_en),
.Cnt_ld(Cnt_ld),
.Cnt_ud(Cnt_ud),
.LCD_EN(Coffee_LCD_EN),
.LCD_RW(Coffee_LCD_RW),
.LCD_RS(Coffee_LCD_RS),
.LCD_DATA(Coffee_LCD_DATA),
.Refund(Coffee_Refund),
.Coin_return(Coffee_Coin_return)
);

endmodule 