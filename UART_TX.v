module UART_TX (
    input wire clk,
    input wire rst,
    input wire Data_Valid,
    input wire PAR_EN,
    input wire [7:0] P_DATA,
    input wire PAR_TYP,
    output wire busy,
    output wire TX_OUT
);
    
wire ser_en, ser_data, ser_done , par_bit;
wire [1:0] mux_sel;
wire [2:0] current_state;
 wire [2:0]  next_state;
serializer s (

    .P_DATA(P_DATA),
    .ser_en(ser_en),
    .Data_Valid(Data_Valid),
    .clk(clk),
    .rst(rst),
    .busy(busy),
    .ser_done(ser_done),
    .ser_data (ser_data)


);


Parity_Calc par_calc (

    .clk(clk),
    .rst(rst),
    .PAR_TYP(PAR_TYP),
    .P_DATA(P_DATA),
    .Data_Valid(Data_Valid),
    .par_bit(par_bit)
);




MUX mux (

   .mux_sel(mux_sel),
    .ser_data(ser_data),
    .par_bit(par_bit),
    .TX_OUT(TX_OUT)

);


FSM_TX fsm (

    .clk(clk),
    .rst(rst),
    .Data_Valid(Data_Valid),
    .PAR_EN(PAR_EN),
    .ser_done(ser_done),
    .mux_sel(mux_sel),
    .busy(busy),
    .ser_en(ser_en)

);

    
endmodule