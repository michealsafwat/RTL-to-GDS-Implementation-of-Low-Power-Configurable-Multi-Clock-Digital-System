module UART_RX (
    input wire clk,
    input wire rst,
    input wire PAR_EN,
    input wire RX_IN,
    input wire PAR_TYP,
    input wire [4:0] Prescale,
    output wire data_valid,
    output wire [7:0] P_DATA,
    output wire parity_error,
    output wire framing_error
);

  wire enable;
  wire [3:0] bit_cnt;
  wire [2:0] edge_cnt;
  wire sampled_bit, data_samp_en;
  wire deser_en, par_bit;
  wire par_chk_en;
  wire strt_chk_en, strt_glitch;
  wire stp_chk_en;
  //wire [2:0] current_state, next_state;

  edge_bit_counter counter (
      .clk(clk),
      .rst(rst),
      .enable(enable),
      .bit_cnt(bit_cnt),
      .edge_cnt(edge_cnt)

  );

  data_sampling dat_samp (
      .prescale(Prescale),
      .clk(clk),
      .rst(rst),
      .RX_IN(RX_IN),
      .data_samp_en(data_samp_en),
      .edge_cnt(edge_cnt),
      .sampled_bit(sampled_bit)
  );


  deserializer deser (
      .clk(clk),
      .rst(rst),
      .edge_cnt(edge_cnt),
      .deser_en(deser_en),
      .PAR_TYP(PAR_TYP),
      .PAR_EN(PAR_EN),
      .data_valid(data_valid),
      .sampled_bit(sampled_bit),
      .P_DATA(P_DATA),
      .par_bit(par_bit)
  );

  Parity_Check par_chk (
      .clk(clk),
  .rst(rst),
      .sampled_bit(sampled_bit),
      .par_chk_en(par_chk_en),
      .par_bit(par_bit),
      .par_err(parity_error)

  );


  Start_Check srt_chk (
      .clk(clk),
  .rst(rst),
      .strt_chk_en(strt_chk_en),
      .sampled_bit(sampled_bit),
      .strt_glitch(strt_glitch)
  );

  Stop_Check stp_chk (
    .clk(clk),
  .rst(rst),
      .stp_chk_en(stp_chk_en),
      .sampled_bit(sampled_bit),
      .stp_err(framing_error)

  );

  FSM_RX fsm (
      .clk(clk),
      .rst(rst),
      .PAR_EN(PAR_EN),
      .RX_IN(RX_IN),
      .par_err(parity_error),
      .strt_glitch(strt_glitch),
      .stp_err(framing_error),
      .bit_cnt(bit_cnt),
      .edge_cnt(edge_cnt),
      .data_samp_en(data_samp_en),
      .par_chk_en(par_chk_en),
      .stp_chk_en(stp_chk_en),
      .strt_chk_en(strt_chk_en),
      .enable(enable),
      .deser_en(deser_en),
      .data_valid(data_valid)

  );



endmodule
