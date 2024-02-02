module LCD_Driver(
CLOCK,
rst_n,
LCD_EN,
LCD_RW,
LCD_RS,
LCD_DATA,
row_1,
row_2
);
input CLOCK;
input rst_n;
output LCD_EN;
output LCD_RW;
output LCD_RS;
output [7:0] LCD_DATA;
wire CLOCK;
wire rst_n;
wire LCD_EN;
wire LCD_RW;
reg [7:0] LCD_DATA;
reg LCD_RS;
reg [5:0] c_state;
reg [5:0] n_state;
input row_1;
input row_2;
wire [127:0] row_1;
wire [127:0] row_2;
parameter TIME_20MS = 1000000 ; //20000000/20=1000_000
parameter TIME_500HZ= 100000  ;
//状态机40种状态,格雷码 
parameter IDLE=8'h00;
parameter SET_FUNCTION=8'h01;
parameter DISP_OFF=8'h03;
parameter DISP_CLEAR=8'h02;
parameter ENTRY_MODE=8'h06;
parameter DISP_ON=8'h07;
parameter ROW1_ADDR=8'h05;
parameter ROW1_0=8'h04;
parameter ROW1_1=8'h0C;
parameter ROW1_2=8'h0D;
parameter ROW1_3=8'h0F;
parameter ROW1_4=8'h0E;
parameter ROW1_5=8'h0A;
parameter ROW1_6=8'h0B;
parameter ROW1_7=8'h09;
parameter ROW1_8=8'h08;
parameter ROW1_9=8'h18;
parameter ROW1_A=8'h19;
parameter ROW1_B=8'h1B;
parameter ROW1_C=8'h1A;
parameter ROW1_D=8'h1E;
parameter ROW1_E=8'h1F;
parameter ROW1_F=8'h1D;
parameter ROW2_ADDR=8'h1C;
parameter ROW2_0=8'h14;
parameter ROW2_1=8'h15;
parameter ROW2_2=8'h17;
parameter ROW2_3=8'h16;
parameter ROW2_4=8'h12;
parameter ROW2_5=8'h13;
parameter ROW2_6=8'h11;
parameter ROW2_7=8'h10;
parameter ROW2_8=8'h30;
parameter ROW2_9=8'h31;
parameter ROW2_A=8'h33;
parameter ROW2_B=8'h32;
parameter ROW2_C=8'h36;
parameter ROW2_D=8'h37;
parameter ROW2_E=8'h35;
parameter ROW2_F=8'h34;
//20ms以达上电稳定(初始化)
reg [19:0] cnt_20ms ;
always  @(posedge CLOCK or negedge rst_n)begin
    if(rst_n==1'b0)begin
        cnt_20ms<=0;
    end
    else if(cnt_20ms == TIME_20MS -1)begin
        cnt_20ms<=cnt_20ms;
    end
    else
        cnt_20ms<=cnt_20ms + 1 ;
end
wire delay_done = (cnt_20ms==TIME_20MS-1)? 1'b1 : 1'b0 ;
//分频
reg [19:0] cnt_500hz;
always  @(posedge CLOCK or negedge rst_n)begin
    if(rst_n==1'b0)begin
        cnt_500hz <= 0;
    end
    else if(delay_done==1)begin
        if(cnt_500hz== TIME_500HZ - 1)
            cnt_500hz<=0;
        else
            cnt_500hz<=cnt_500hz + 1 ;
    end
    else
        cnt_500hz<=0;
end

assign LCD_EN = (cnt_500hz>(TIME_500HZ-1)/2)? 1'b0 : 1'b1;  
assign write_flag = (cnt_500hz==TIME_500HZ - 1) ? 1'b1 : 1'b0 ;
always  @(posedge CLOCK or negedge rst_n)begin
    if(rst_n==1'b0)begin
        c_state <= IDLE    ;
    end
    else if(write_flag==1) begin
        c_state<= n_state  ;
    end
    else
        c_state<=c_state   ;
end

always  @(*)begin
    case (c_state)
		IDLE:n_state=SET_FUNCTION;
		SET_FUNCTION:n_state=DISP_OFF;
		DISP_OFF:n_state=DISP_CLEAR;
		DISP_CLEAR:n_state=ENTRY_MODE;
		ENTRY_MODE:n_state=DISP_ON;
		DISP_ON:n_state=ROW1_ADDR;
		ROW1_ADDR:n_state=ROW1_0;
		ROW1_0:n_state=ROW1_1;
		ROW1_1:n_state=ROW1_2;
		ROW1_2:n_state=ROW1_3;
		ROW1_3:n_state=ROW1_4;
		ROW1_4:n_state=ROW1_5;
		ROW1_5:n_state=ROW1_6;
		ROW1_6:n_state=ROW1_7;
		ROW1_7:n_state=ROW1_8;
		ROW1_8:n_state=ROW1_9;
		ROW1_9:n_state=ROW1_A;
		ROW1_A:n_state=ROW1_B;
		ROW1_B:n_state=ROW1_C;
		ROW1_C:n_state=ROW1_D;
		ROW1_D:n_state=ROW1_E;
		ROW1_E:n_state=ROW1_F;
		ROW1_F:n_state=ROW2_ADDR;
		ROW2_ADDR:n_state=ROW2_0;
		ROW2_0:n_state=ROW2_1;
		ROW2_1:n_state=ROW2_2;
		ROW2_2:n_state=ROW2_3;
		ROW2_3:n_state=ROW2_4;
		ROW2_4:n_state=ROW2_5;
		ROW2_5:n_state=ROW2_6;
		ROW2_6:n_state=ROW2_7;
		ROW2_7:n_state=ROW2_8;
		ROW2_8:n_state=ROW2_9;
		ROW2_9:n_state=ROW2_A;
		ROW2_A:n_state=ROW2_B;
		ROW2_B:n_state=ROW2_C;
		ROW2_C:n_state=ROW2_D;
		ROW2_D:n_state=ROW2_E;
		ROW2_E:n_state=ROW2_F;
		ROW2_F:n_state=ROW1_ADDR;//循环到1-1进行扫描显示
     default: n_state = n_state;
   endcase 
   end   

   assign LCD_RW = 0;
   always  @(posedge CLOCK or negedge rst_n)begin
       if(rst_n==1'b0)begin
           LCD_RS <= 0 ;   //order or data  0: order 1:data
       end
       else if(write_flag == 1)begin
           if((n_state==SET_FUNCTION)||(n_state==DISP_OFF)||
              (n_state==DISP_CLEAR)||(n_state==ENTRY_MODE)||
              (n_state==DISP_ON ) ||(n_state==ROW1_ADDR)||
              (n_state==ROW2_ADDR))
			begin
           LCD_RS<=0 ;
           end 
           else  begin
           LCD_RS<= 1;
           end
       end
       else begin
           LCD_RS<=LCD_RS;
       end     
   end                   

   always  @(posedge CLOCK or negedge rst_n)begin
       if(rst_n==1'b0)begin
           LCD_DATA<=0 ;
       end
       else  if(write_flag)begin
           case(n_state)
                 IDLE: LCD_DATA <= 8'hxx;
         SET_FUNCTION: LCD_DATA <= 8'h38; //2*16 5*8 8位数据
             DISP_OFF: LCD_DATA <= 8'h08;//8'b0000_1000,显示开关设置:D=0(DB2,显示关),C=0(DB1,光标不显示),D=0(DB0,光标不闪烁)
           DISP_CLEAR: LCD_DATA <= 8'h01;//8'b0000_0001,清屏
           ENTRY_MODE: LCD_DATA <= 8'h06;//8'b0000_0110,进入模式设置:I/D=1(DB1,写入新数据光标右移),S=0(DB0,显示不移动)
           DISP_ON   : LCD_DATA <= 8'h0c;//8'b0000_1100,显示开关设置:D=1(DB2,显示开),C=0(DB1,光标不显示),D=0(DB0,光标不闪烁)
            ROW1_ADDR: LCD_DATA <= 8'h80;//8'b1000_0000,设置DDRAM地址:00H->1-1,第一行第一位
				//将输入的row_1以每8-bit拆分,分配给对应的显示位
               ROW1_0: LCD_DATA <= row_1 [127:120];
               ROW1_1: LCD_DATA <= row_1 [119:112];
               ROW1_2: LCD_DATA <= row_1 [111:104];
               ROW1_3: LCD_DATA <= row_1 [103: 96];
               ROW1_4: LCD_DATA <= row_1 [ 95: 88];
               ROW1_5: LCD_DATA <= row_1 [ 87: 80];
               ROW1_6: LCD_DATA <= row_1 [ 79: 72];
               ROW1_7: LCD_DATA <= row_1 [ 71: 64];
               ROW1_8: LCD_DATA <= row_1 [ 63: 56];
               ROW1_9: LCD_DATA <= row_1 [ 55: 48];
               ROW1_A: LCD_DATA <= row_1 [ 47: 40];
               ROW1_B: LCD_DATA <= row_1 [ 39: 32];
               ROW1_C: LCD_DATA <= row_1 [ 31: 24];
               ROW1_D: LCD_DATA <= row_1 [ 23: 16];
               ROW1_E: LCD_DATA <= row_1 [ 15:  8];
               ROW1_F: LCD_DATA <= row_1 [  7:  0];
             ROW2_ADDR: LCD_DATA <= 8'hc0;     //8'b1100_0000,设置DDRAM地址:40H->2-1,第二行第一位
               ROW2_0: LCD_DATA <= row_2 [127:120];
               ROW2_1: LCD_DATA <= row_2 [119:112];
               ROW2_2: LCD_DATA <= row_2 [111:104];
               ROW2_3: LCD_DATA <= row_2 [103: 96];
               ROW2_4: LCD_DATA <= row_2 [ 95: 88];
               ROW2_5: LCD_DATA <= row_2 [ 87: 80];
               ROW2_6: LCD_DATA <= row_2 [ 79: 72];
               ROW2_7: LCD_DATA <= row_2 [ 71: 64];
               ROW2_8: LCD_DATA <= row_2 [ 63: 56];
               ROW2_9: LCD_DATA <= row_2 [ 55: 48];
               ROW2_A: LCD_DATA <= row_2 [ 47: 40];
               ROW2_B: LCD_DATA <= row_2 [ 39: 32];
               ROW2_C: LCD_DATA <= row_2 [ 31: 24];
               ROW2_D: LCD_DATA <= row_2 [ 23: 16];
               ROW2_E: LCD_DATA <= row_2 [ 15:  8];
               ROW2_F: LCD_DATA <= row_2 [  7:  0];
					default: LCD_DATA = LCD_DATA;
           endcase                     
       end
       else
              LCD_DATA<=LCD_DATA ;
   end
endmodule  