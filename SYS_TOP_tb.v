`timescale 1ns/100ps
module SYS_TOP_tb ();


    reg REF_CLK_tb;
    reg RST_tb;
    reg UART_CLK_tb;
    reg RX_IN_tb;
    wire TX_OUT_tb;
    wire parity_error_tb;
    wire framing_error_tb;


 parameter CLK_PERIOD_UART  = 104166.667;
parameter CLK_PERIOD_REF  = 20;



initial begin
    $dumpfile("SYS_TOP.vcd") ;
    $dumpvars ;
initialize();
reset ();


RX_IN_tb = 1'b0;

// ALU without operands 
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b1;
 #(8*CLK_PERIOD_UART)
 RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_UART)
//ALU func = NOR 
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b0;
#(8*CLK_PERIOD_UART)
RX_IN_tb = 1'b0;
 #(8*CLK_PERIOD_UART)
 RX_IN_tb = 1'b1;
#(8*CLK_PERIOD_UART)

#(40*CLK_PERIOD_UART)

$stop;
end












task initialize ();
begin
    REF_CLK_tb = 1'b0;
    UART_CLK_tb = 1'b0; 
    RX_IN_tb = 1'b0;

end 
endtask

task reset ();
begin
    RST_tb = 1'b1;
    #CLK_PERIOD_REF
    RST_tb = 1'b0;
    #10
    RST_tb = 1'b1;
end
endtask

SYS_TOP DUT(
   .REF_CLK(REF_CLK_tb),
    .RST(RST_tb),
    .UART_CLK(UART_CLK_tb),
    .RX_IN(RX_IN_tb),
    .TX_OUT(TX_OUT_tb),
    .parity_error(parity_error_tb),
    .framing_error(framing_error_tb)
);


always #10 REF_CLK_tb = ~ REF_CLK_tb;
always #52083.33333 UART_CLK_tb = ~ UART_CLK_tb;
endmodule