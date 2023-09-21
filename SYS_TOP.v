module SYS_TOP (
    input  wire REF_CLK,
    input  wire RST,
    input  wire UART_CLK,
    input  wire RX_IN,
    output wire TX_OUT,
    output wire parity_error,
    output wire framing_error
);

  wire SYNC_RST_REG_FILE, SYNC_RST_DSYNC;
  wire ALU_CLK, Gate_EN;
  wire                      TX_CLK;
  wire CLK_EN = 1'b1;
  wire bus_en = 1'b1;
  wire on = 1'b1;
  wire                [7:0] UART_Config;
  wire                [7:0] div_ratio;
wire dv, en_pulse, A_V , b , bs;
wire [15:0] ALU_OUTPUT;
wire [3:0] ALU_FUNCTION , ADDRESS;
wire [7:0] RX_PDATAS , RX_PDATA , TX_PDATAS, TX_PDATA,  Read_Data , OP_A, OP_B, Write_Data;

  RST_SYNC RST_SYNC_1 (
      .RST(RST),
      .CLK(REF_CLK),
      .SYNC_RST(SYNC_RST_REG_FILE)

  );

  RST_SYNC RST_SYNC_2 (
      .RST(RST),
      .CLK(TX_CLK),
      .SYNC_RST(SYNC_RST_DSYNC)

  );


  CLK_GATE CLock_Gating (

      .CLK_EN(1'b1),
      .CLK(REF_CLK),
      .GATED_CLK(GATED_CLK)

  );
  ClkDiv Clock_Divider (

      .i_ref_clk(UART_CLK),
      .i_rst_n(RST),
      .i_clk_en(1'b1),
      .i_div_ratio(4'b1000),
      .o_div_clk(TX_CLK)

  );


  SYS_CTRL sys_ctrl (

      .clk(REF_CLK),
      .rst(RST),
      .RX_D_VLD_DS(en_pulse),
      .RX_P_DATA_DS(RX_PDATAS),
      .Busy(bs),
      .ALU_OUT(ALU_OUTPUT),
      .ALU_OUT_VALID(A_V),
      .Rd_DATA(Read_Data),
      .Rd_DATA_Valid(RdData_VLD),
      .TX_P_DATA(TX_PDATA),
      .TX_D_VLD(bus_enable),
      .FUN(ALU_FUNCTION),
      .EN(EN),
      .WrEn(WrEn),
      .RdEn(RdEn),
      .Gate_EN(on),
      .Addr(ADDRESS),
      .Wr_D(Write_Data)


  );

  BIT_SYNC bit_sync (

      .clk  (REF_CLK),
      .rst  (RST),
      .ASYNC(b),
      .SYNC (bs)



  );

  ALU alu (
      .A(OP_A),
      .B(OP_B),
      .EN(EN),
      .ALU_FUN(ALU_FUNCTION),
      .CLK(GATED_CLK),
      .RST(RST),
      .ALU_OUT(ALU_OUTPUT),
      .OUT_VALID(A_V)
  );



  RegFile reg_file (
      .CLK(REF_CLK),
      .RST(RST),
      .RdEn(RdEn),
      .WrEn(WrEn),
      .Address(ADDRESS),
      .WrData(Write_Data),
      .RdData(Read_Data),
      .RdData_VLD(Rd_DATA_Valid),
      .REG0(OP_A),
      .REG1(OP_B),
      .REG2(UART_Config),
      .REG3(div_ratio)


  );



  DATA_SYNC data_sync_rx (

      .Unsync_bus(RX_PDATA),
      .bus_enable(dv),
      .CLK(REF_CLK),
      .RST(RST),
      .sync_bus(RX_PDATAS),
      .enable_pulse(en_pulse)

  );

  DATA_SYNC data_sync_tx (

      .Unsync_bus(TX_PDATA),
      .bus_enable(TX_D_VLD),
      .CLK(TX_CLK),
      .RST(RST),
      .sync_bus(TX_PDATAS),
      .enable_pulse(TX_D_VLD_DS)



  );

  UART uart (

      .RST(RST),
      .RX_CLK(UART_CLK),
      .TX_CLK(TX_CLK),
      .RX_IN(RX_IN),
      .TX_P_DATA_DS(TX_PDATAS),
      .TX_D_VLD_DS(enable_pulse),
      .config_PAR_EN(1'b0),
      .config_PAR_TYP(1'b0),
      .Prescale(5'b01000),
      .TX_OUT(TX_OUT),
      .busy(b),
      .RX_P_DATA(RX_PDATA),
      .RX_D_VLD(dv),
.parity_error(parity_error),
.framing_error(framing_error)



  );


endmodule
