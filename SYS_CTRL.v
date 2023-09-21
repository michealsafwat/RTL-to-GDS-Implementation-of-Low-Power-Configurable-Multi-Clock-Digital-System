module SYS_CTRL  #( parameter FUN_WIDTH = 4,  parameter WIDTH = 8, DEPTH = 16, ADDR = 4,OUT_WIDTH = 2*WIDTH)

(
    input wire clk,
    input wire rst,
    input wire RX_D_VLD_DS,
    input wire [WIDTH-1:0] RX_P_DATA_DS,
    input wire Busy,
    input wire [OUT_WIDTH-1:0] ALU_OUT,
    input wire ALU_OUT_VALID,
    input wire [WIDTH-1:0] Rd_DATA,
    input wire Rd_DATA_Valid,
    output wire [WIDTH-1:0] TX_P_DATA,
    output wire TX_D_VLD,
    output wire [FUN_WIDTH-1:0] FUN,
    output wire EN,
    output wire WrEn,
    output wire RdEn,
    output wire Gate_EN,
    output wire [ADDR-1:0] Addr,
    output wire [WIDTH-1:0] Wr_D
);


CTRL_RX ctrl_rx (

    .clk(clk),
    .rst(rst),
    .Gate_EN(Gate_EN),
    .RX_D_VLD(RX_D_VLD_DS),
    .RX_P_DATA(RX_P_DATA_DS),
    .FUN(FUN),
    .EN(EN),
    .WrEn(WrEn),
    .RdEn(RdEn),
    .Addr(Addr),
    .Wr_D(Wr_D)
);


CTRL_TX ctrl_tx (

.rst(rst),
.clk(clk),
.Busy(Busy),
.ALU_OUT(ALU_OUT),
.ALU_OUT_VALID(ALU_OUT_VALID),
.Rd_DATA(Rd_DATA),
.Rd_DATA_Valid(Rd_DATA_Valid),
.TX_P_DATA(TX_P_DATA),
.TX_D_VLD(TX_D_VLD)
);


endmodule
