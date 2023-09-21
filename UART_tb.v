`timescale 1ns/100ps
module UART_tb ();
    

reg RST_tb;
reg RX_CLK_tb;
reg TX_CLK_tb;
reg RX_IN_tb;
reg [7:0] TX_P_DATA_DS_tb;
reg TX_D_VLD_DS_tb;
reg config_PAR_EN_tb;
reg config_PAR_TYP_tb;
reg [4:0] Prescale_tb;
wire TX_OUT_tb;
 wire busy_tb;
 wire [7:0] RX_P_DATA_tb;
 wire RX_D_VLD_tb;
wire parity_error_tb;
wire framing_error_tb;


    parameter CLK_PERIOD_RX  = 104166.667;
parameter CLK_PERIOD_TX  = 40;

initial begin
     $dumpfile("UART.vcd") ;
    $dumpvars ;
initialize();
reset ();

Prescale_tb = 5'b0;
RX_IN_tb = 1'b0;
config_PAR_EN_tb = 1'b0;
config_PAR_TYP_tb =1'b0;

#(8*CLK_PERIOD_RX)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_RX)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD_RX)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_RX)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD_RX)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_RX)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD_RX)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_RX)
RX_IN_tb = 1'b0;
 #(8*CLK_PERIOD_RX)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_RX)
#(0.5*CLK_PERIOD_RX)
TX_D_VLD_DS_tb = 1'b1;
TX_P_DATA_DS_tb = RX_P_DATA_tb;
#(8*CLK_PERIOD_RX)
TX_D_VLD_DS_tb = 1'b0;
#(11*CLK_PERIOD_TX)

/*  RX_IN_tb = 1'b0;

Prescale_tb = 3'b0;

config_PAR_EN_tb = 1'b0;
config_PAR_TYP_tb =1'b0;

#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD)
RX_IN_tb = 1'b1;


#(10*CLK_PERIOD) */
$stop;
end


task initialize ();
begin
    RX_CLK_tb = 1'b0;
    TX_CLK_tb = 1'b0; 
    config_PAR_EN_tb = 1'b0;
    RX_IN_tb = 1'b0;
    config_PAR_TYP_tb = 1'b0;
    Prescale_tb = 3'b0;
    TX_D_VLD_DS_tb = 1'b0;
end 
endtask

task reset ();
begin
    RST_tb = 1'b1;
    #CLK_PERIOD_RX
    RST_tb = 1'b0;
    #2.5
    RST_tb = 1'b1;
end
endtask

UART DUT(

.RST(RST_tb),
.RX_CLK(RX_CLK_tb),
.TX_CLK(TX_CLK_tb),
.RX_IN(RX_IN_tb),
.TX_P_DATA_DS(TX_P_DATA_DS_tb),
.TX_D_VLD_DS(TX_D_VLD_DS_tb),
.config_PAR_EN(config_PAR_EN_tb),
.config_PAR_TYP(config_PAR_TYP_tb),
.Prescale(Prescale_tb),
.TX_OUT(TX_OUT_tb),
.busy(busy_tb),
.RX_P_DATA(RX_P_DATA_tb),
.RX_D_VLD(RX_D_VLD_tb),
.parity_error(parity_error_tb),
.framing_error(framing_error_tb)
);


always #52083.33333 RX_CLK_tb = ~ RX_CLK_tb;
always #20 TX_CLK_tb = ~ TX_CLK_tb;
endmodule