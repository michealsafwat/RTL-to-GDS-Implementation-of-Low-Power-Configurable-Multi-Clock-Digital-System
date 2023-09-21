module UART #(parameter DATA_WIDTH = 8) (
input wire RST,
input wire RX_CLK,
input wire TX_CLK,
input wire RX_IN,
input wire [DATA_WIDTH-1 : 0] TX_P_DATA_DS,
input wire TX_D_VLD_DS,
input wire config_PAR_EN,
input wire config_PAR_TYP,
input wire [4:0] Prescale,
output wire TX_OUT,
output wire busy,
output wire [DATA_WIDTH-1:0] RX_P_DATA,
output wire RX_D_VLD,
output wire parity_error,
    output wire framing_error

);





UART_TX uart_tx (
    .clk(TX_CLK),
    .rst(RST),
    .Data_Valid(TX_D_VLD_DS),
    .PAR_EN(config_PAR_EN),
    .P_DATA(TX_P_DATA_DS),
    .PAR_TYP(config_PAR_TYP),
    .busy(busy),
    .TX_OUT(TX_OUT)



);


UART_RX uart_rx (

    .clk(RX_CLK),
    .rst(RST),
    .PAR_EN(config_PAR_EN),
    .RX_IN(RX_IN),
    .PAR_TYP(config_PAR_TYP),
    .Prescale(Prescale),
    .data_valid(RX_D_VLD),
    .P_DATA(RX_P_DATA),
.parity_error(parity_error),
.framing_error(framing_error)
  
);

endmodule