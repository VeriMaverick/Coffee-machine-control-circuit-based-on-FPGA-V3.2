`timescale 1 ps/ 1 ps
module Coffee_tb();
// constants                                           
// general purpose registers
reg eachvec;
// test vector input registers
reg Clock;
reg Cof_rdy;
reg Coin_1;
reg Coin_5;
reg Cup_rdy;
reg Reset_n;
reg Coin_return;
// wires                                               
wire Inject_cof;
wire Place_cup;
wire Refund;
// assign statements (if any)                          
Coffee i1 (
// port map - connection between master ports and signals/registers   
	.Coffee_Clock(Clock),
	.Coffee_Cof_rdy(Cof_rdy),
	.Coffee_Coin_1(Coin_1),
	.Coffee_Coin_5(Coin_5),
	.Coffee_Cup_rdy(Cup_rdy),
	.Coffee_Inject_cof(Inject_cof),
	.Coffee_Place_cup(Place_cup),
	.Coffee_Refund(Refund),
	.Coffee_Reset_n(Reset_n),
	.Coffee_Coin_return(Coin_return)
);

parameter Clock_p=20;
initial 
Clock=0;
always #(Clock_p/2) Clock=~Clock;

initial                                                
begin                                                  
// code that executes only once                        
// insert code here --> begin                          
                                                       
// --> end   
Reset_n=0;
Coin_1=0;
Coin_5=0;
Cup_rdy=0;
Cof_rdy=0;
Coin_return=0;
#100 Reset_n=1;
#200 Coin_1=1;
#200 Coin_1=0;
#200 Coin_1=1;
#200 Coin_1=0;
#200 Coin_1=1;
#200 Coin_1=0;
#200 Cup_rdy=1;
#200 Cup_rdy=0;
#200 Cof_rdy=1;
#200 Cof_rdy=0;

#500

#200 Coin_5=1;
#200 Coin_5=0;
#200 Cup_rdy=1;
#200 Cup_rdy=0;
#200 Cof_rdy=1;
#200 Cof_rdy=0;

#500

#200 Coin_5=1;
#200 Coin_5=0;
#200 Cup_rdy=1;
#200 Cup_rdy=0;
#200 Cof_rdy=1;
#200 Cof_rdy=0;

#500

#200 Coin_1=1;
#200 Coin_1=0;
#200 Coin_5=1;
#200 Coin_5=0;
#200 Cup_rdy=1;
#200 Cup_rdy=0;
#200 Cof_rdy=1;
#200 Cof_rdy=0;

#500

#200 Coin_1=1;
#200 Coin_1=0;
#200 Coin_1=1;
#200 Coin_1=0;
#200 Coin_5=1;
#200 Coin_5=0;
#200 Cup_rdy=1;
#200 Cup_rdy=0;
#200 Cof_rdy=1;
#200 Cof_rdy=0;

#900 $stop;                                       
$display("Running testbench");                       
end                                                    
always                                                 
// optional sensitivity list                           
// @(event1 or event2 or .... eventn)                  
begin                                                  
// code executes for every event on sensitivity list   
// insert code here --> begin                          
                                                       
@eachvec;                                              
// --> end                                             
end                                                    
endmodule

