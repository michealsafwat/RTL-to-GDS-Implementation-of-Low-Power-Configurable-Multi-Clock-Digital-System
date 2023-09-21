`timescale 1ns/100ps
module UART_RX_tb ();

    reg clk_tb;
    reg rst_tb;
    reg PAR_EN_tb;
    reg RX_IN_tb;
    reg PAR_TYP_tb;
    reg [4:0] Prescale_tb;
     wire data_valid_tb;
     wire [7:0] P_DATA_tb;
wire parity_error_tb;
wire framing_error_tb;
parameter CLK_PERIOD  = 5;


initial begin
    $dumpfile("UART_RX.vcd") ;
    $dumpvars ;
initialize();
reset ();

 Prescale_tb = 5'b0;
PAR_EN_tb = 1'b0;
PAR_TYP_tb =1'b0;
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
 RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)  

  Prescale_tb = 5'b0;
RX_IN_tb = 1'b0;
PAR_EN_tb = 1'b0;
PAR_TYP_tb =1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
//address
/* RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
Prescale_tb = 5'b0;
PAR_EN_tb = 1'b0;
PAR_TYP_tb =1'b0;
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
 



 Prescale_tb = 5'b0;
PAR_EN_tb = 1'b0;
PAR_TYP_tb =1'b0;
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
 RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)    
 */
    



#(40*CLK_PERIOD) 
$stop;
end


task initialize ();
begin
    clk_tb = 1'b0; 
    PAR_EN_tb = 1'b0;
    RX_IN_tb = 1'b0;
    PAR_TYP_tb = 1'b0;
    Prescale_tb = 3'b0;
end 
endtask

task reset ();
begin
    rst_tb = 1'b1;
    #CLK_PERIOD
    rst_tb = 1'b0;
    #2.5
    rst_tb = 1'b1;
end
endtask

UART_RX DUT (
    .clk(clk_tb),
    .rst(rst_tb),
    .PAR_EN(PAR_EN_tb),
    .RX_IN(RX_IN_tb),
    .PAR_TYP(PAR_TYP_tb),
    .Prescale(Prescale_tb),
    .data_valid(data_valid_tb),
    .P_DATA(P_DATA_tb),
    .parity_error(parity_error_tb),
.framing_error(framing_error_tb)

  
);

always #2.5 clk_tb = ~ clk_tb;
endmodule