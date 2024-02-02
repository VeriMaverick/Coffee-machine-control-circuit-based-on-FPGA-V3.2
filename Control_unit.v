module Control_unit(
Clock,
Reset_n,
Coin_1,
Coin_5,
Cup_rdy,
Cof_rdy,
Place_cup,
Inject_cof,
Less_3,
Eql_3,
Grt_3,
sel_en,
sel_sel,
Cnt_clr,
Cnt_en,
Cnt_ld,
Cnt_ud,
LCD_EN,
LCD_RW,
LCD_RS,
LCD_DATA,
Refund,
Coin_return
);

input Clock;
input Reset_n;
input Coin_1;
input Coin_5;
input Cup_rdy;
input Cof_rdy;
input Coin_return;

input Less_3;
input Eql_3;
input Grt_3;


output Place_cup;
output Inject_cof;
output sel_en;
output sel_sel;
output Cnt_clr;
output Cnt_en;
output Cnt_ld;
output Cnt_ud;
output Refund;


reg [2:0] present_state;
reg [2:0] next_state;
reg Place_cup;
reg Inject_cof;
reg sel_en;
reg sel_sel;
reg Cnt_clr;
reg Cnt_en;
reg Cnt_ld;
reg Cnt_ud;
reg Refund;
//Edge extraction
reg a;
reg b;
reg c;
reg d;
reg e;
reg f;
reg gg;
reg hh;
reg ii;

parameter Init    =3'b000;
parameter Wait    =3'b001;
parameter Add_1   =3'b011;
parameter Add_5   =3'b010;
parameter return_1=3'b110;
parameter Comp    =3'b111;
parameter Place   =3'b101;
parameter Release =3'b100;

output LCD_EN;
output LCD_RW;
output LCD_RS;
output [7:0] LCD_DATA;
reg [127:0] row_1;
reg [127:0] row_2;

LCD_Driver U1(
.CLOCK(Clock),
.rst_n(Reset_n),
.LCD_EN(LCD_EN),
.LCD_RW(LCD_RW),
.LCD_RS(LCD_RS),
.LCD_DATA(LCD_DATA),
.row_1(row_1),
.row_2(row_2)
);

//Edge extraction
always @ (posedge Clock)
begin
	a<=~Coin_1;
	b<=a;
	c<=a&&(~b);
end
always @ (posedge Clock)
begin
	d<=~Coin_5;
	e<=d;
	f<=d&&(~e);
end
always @ (posedge Clock)
begin
	gg<=~Coin_return;
	hh<=gg;
	ii<=gg&&(~hh);
end


always @ (posedge Clock , negedge Reset_n)
begin
	if(!Reset_n)
		present_state <= Init;
	else
		present_state <= next_state;
end

//Control unit state
always @ (*)
begin
	case(present_state)
		Init:
			begin 
				next_state = Wait;
				sel_en  = 1'b0;		//0	选择器使能关
				sel_sel = 1'b0;		//0	投币1元
				Cnt_clr = 1'b0;		//0	计数器清零
				Cnt_en  = 1'b0;		//0	计数器使能关
				Cnt_ld  = 1'b0;		//0	不加载预值
				Cnt_ud  = 1'b0;		//0	下行计数关
				Place_cup  = 1'b0;
				Inject_cof = 1'b0;
				Refund = 1'b0;
			end
		Wait:
			begin
		  	row_1 <="Please invest 1 ";    //第一行显示的16*1字节个内容
         row_2 <="RMB or 5 RMB ^.^";    //第二行显示的16*1字节个内容
				if(c)
					begin 
						next_state = Add_1;
						sel_en = 1'b0;		//0	选择器使能关
						sel_sel= 1'b0;		//0	投币1元
						Cnt_clr= 1'b1;		//1	计数器不清零
						Cnt_en = 1'b0;		//0	计数器使能关
						Cnt_ld = 1'b0;		//0	不加载预值
						Cnt_ud = 1'b0;		//0	下行计数关
						Place_cup = 1'b0;
						Inject_cof= 1'b0;
						Refund = 1'b0;
					end
				else if(f)
					begin
						next_state = Add_5;
						sel_en = 1'b0;		//0	选择器使能关
						sel_sel= 1'b0;		//0	投币1元
						Cnt_clr= 1'b1;		//1	计数器不清零
						Cnt_en = 1'b0;		//0	计数器使能关
						Cnt_ld = 1'b0;		//0	不加载预值
						Cnt_ud = 1'b0;		//0	下行计数关
						Place_cup = 1'b0;
						Inject_cof= 1'b0;
						Refund = 1'b0;
					end
				else
					begin
						next_state = Wait;
						sel_en = 1'b0;		//0	选择器使能关
						sel_sel= 1'b0;		//0	投币1元
						Cnt_clr= 1'b1;		//1	计数器不清零
						Cnt_en = 1'b0;		//0	计数器使能关
						Cnt_ld = 1'b0;		//0	不加载预值
						Cnt_ud = 1'b0;		//0	下行计数关
						Place_cup = 1'b0;
						Inject_cof= 1'b0;
						Refund = 1'b0;
					end
			end
		Add_1:
			begin 
				next_state = Comp;
				sel_en = 1'b1;		//1	选择器使能开
				sel_sel= 1'b0;		//0	投币1元
				Cnt_clr= 1'b1;		//1	计数器不清零
				Cnt_en = 1'b1;		//1	计数器使能开
				Cnt_ld = 1'b1;		//1	加载预值
				Cnt_ud = 1'b0;		//0	下行计数关
				Place_cup = 1'b0;
				Inject_cof= 1'b0;
				Refund = 1'b0;
			end	
		Add_5:
			begin 
				next_state = return_1;
				sel_en = 1'b1;		//1	选择器使能开
				sel_sel= 1'b1;		//1	投币5元
				Cnt_clr= 1'b1;		//1	计数器不清零
				Cnt_en = 1'b1;		//1	计数器使能开
				Cnt_ld = 1'b1;		//1	加载预值
				Cnt_ud = 1'b0;		//0	下行计数关
				Place_cup = 1'b0;
				Inject_cof= 1'b0;
				Refund = 1'b0;
			end
		return_1:
			begin
					  	row_1 <="Please wait for ";    //第一行显示的16*1字节个内容
                  row_2 <="coin refund! ^_^";    //第二行显示的16*1字节个内容
				Refund = 1'b1;		//退款信号
				if(ii)
					begin
						next_state = Comp;
						sel_en = 1'b0;		//0	选择器使能关
						sel_sel= 1'b1;		//1	投币5元
						Cnt_clr= 1'b1;		//1	计数器不清零
						Cnt_en = 1'b1;		//1	计数器使能开
						Cnt_ld = 1'b0;		//0	不加载预值
						Cnt_ud = 1'b1;		//1	下行计数开
						Place_cup = 1'b0;
						Inject_cof= 1'b0;
					end
	   		else 
					begin
					next_state = return_1;
					sel_en = 1'b0;		//0	选择器使能关
					sel_sel= 1'b0;		//0	投币1元
					Cnt_clr= 1'b1;		//1	计数器不清零
					Cnt_en = 1'b0;		//0	计数器使能关
					Cnt_ld = 1'b0;		//0	不加载预值
					Cnt_ud = 1'b0;		//0	下行计数关
					Place_cup = 1'b0;
					Inject_cof= 1'b0;
					Refund = 1'b1;
					end

			end
		
		Comp:
			begin
				if(Less_3)
					begin
						next_state = Wait;
						sel_en  = 1'b0;		//0	选择器使能关
						sel_sel = 1'b0;		//0	投币1元
						Cnt_clr = 1'b1;		//1	计数器不清零
						Cnt_en  = 1'b0;		//0	计数器使能关
						Cnt_ld  = 1'b1;		//1	加载预值
						Cnt_ud = 1'b0;		//0	下行计数关
						Place_cup = 1'b0;
						Inject_cof= 1'b0;
						Refund = 1'b0;
					end
				else if(Eql_3)
					begin
						next_state = Place;
						sel_en = 1'b0;		//0	选择器使能关
						sel_sel= 1'b0;		//0	投币1元
						Cnt_clr= 1'b1;		//1	计数器不清零
						Cnt_en = 1'b0;		//0	计数器使能关
						Cnt_ld = 1'b0;		//0	不加载预值
						Cnt_ud = 1'b0;		//0	下行计数关
						Place_cup = 1'b1;
						Inject_cof= 1'b0;
						Refund = 1'b0;
					end
				else if(Grt_3)
					begin
						next_state = return_1;
						sel_en = 1'b0;		//0	选择器使能关
						sel_sel= 1'b0;		//0	投币1元
						Cnt_clr= 1'b1;		//1	计数器不清零
						Cnt_en = 1'b0;		//0	计数器使能关
						Cnt_ld = 1'b0;		//0	不加载预值
						Cnt_ud = 1'b0;		//0	下行计数关
						Place_cup = 1'b0;
						Inject_cof= 1'b0;
						Refund = 1'b0;
					end
				else
					begin
						next_state = Comp;
						sel_en = 1'b0;		//0	选择器使能关
						sel_sel= 1'b0;		//0	投币1元
						Cnt_clr= 1'b1;		//1	计数器不清零
						Cnt_en = 1'b0;		//0	计数器使能关
						Cnt_ld = 1'b0;		//0	不加载预值
						Cnt_ud = 1'b0;		//0	下行计数关
						Place_cup = 1'b0;
						Inject_cof= 1'b0;
						Refund = 1'b0;
					end
			end	
		Place:
			begin 
			Place_cup = 1'b1;
				if(Cup_rdy)
					begin
						next_state = Release;
						sel_en = 1'b0;		//0	选择器使能关
						sel_sel= 1'b0;		//0	投币1元
						Cnt_clr= 1'b1;		//1	计数器不清零
						Cnt_en = 1'b0;		//0	计数器使能关
						Cnt_ld = 1'b0;		//0	不加载预值
						Cnt_ud = 1'b0;		//0	下行计数关
						Place_cup = 1'b0;
						Inject_cof= 1'b1;
						Refund = 1'b0;
					end
				else 
					next_state = Place;	
			end	 
		Release:
			begin 
					row_1 <="The cup is alre-";    //第一行显示的16*1字节个内容
               row_2 <="ady in place !  "; 
				Inject_cof= 1'b1;
				if(Cof_rdy)
					begin
						next_state = Init;
						sel_en = 1'b0;		//0	选择器使能关
						sel_sel= 1'b0;		//0	投币1元
						Cnt_clr= 1'b1;		//1	计数器不清零
						Cnt_en = 1'b0;		//0	计数器使能关
						Cnt_ld = 1'b0;		//0	不加载预值
						Cnt_ud = 1'b0;		//0	下行计数关
						Place_cup = 1'b0;
						Inject_cof= 1'b0;
						Refund = 1'b0;
					end
				else 
					next_state = Release;			
			end
		default:
			begin 
			   present_state = Init;
				next_state = Init;
				sel_en = 1'b0;		//0	选择器使能关
				sel_sel= 1'b0;		//0	投币1元
				Cnt_clr= 1'b0;		//0	计数器清零
				Cnt_en = 1'b1;		//1	计数器使能开
				Cnt_ld = 1'b0;		//0	不加载预值
				Cnt_ud = 1'b0;		//0	下行计数关
				Place_cup = 1'b0;
				Inject_cof= 1'b0;
				Refund = 1'b0;
			end
	endcase					
end
endmodule 