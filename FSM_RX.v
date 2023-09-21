module FSM_RX (
    input wire clk,
    input wire rst,
    input wire PAR_EN,
    input wire RX_IN,
    input wire par_err,
    input wire strt_glitch,
    input wire stp_err,
    input wire [3:0] bit_cnt,
    input wire [2:0] edge_cnt,
    output reg data_samp_en,
    output reg par_chk_en,
    output reg stp_chk_en,
    output reg strt_chk_en,
    output reg enable,
    output reg deser_en,
    output reg data_valid


);

  reg [2:0] current_state;
  reg [2:0] next_state;

  localparam idle = 3'b000;
  localparam start_bit = 3'b001;
  localparam data_bits = 3'b011;
  localparam parity_bit = 3'b111;
  localparam stop_bit = 3'b101;
  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      current_state <= idle;
    end else begin
      current_state <= next_state;
    end
  end


  always @(*) begin

    // next_state = idle;
    deser_en = 1'b0;
    data_valid = 1'b0;
    data_samp_en = 1'b0;
    enable = 1'b0;
    par_chk_en = 1'b0;
    stp_chk_en = 1'b0;
    strt_chk_en = 1'b0;
    case (current_state)
      idle: begin
        /*      data_samp_en = 1'b0;
        par_chk_en = 1'b0;
        stp_chk_en = 1'b0;
        strt_chk_en = 1'b0;
        enable = 1'b0;
        deser_en = 1'b0;
        data_valid = 1'b0; */

        if (RX_IN == 1'b0) begin
          strt_chk_en = 1'b1;
          enable = 1'b1;
          data_samp_en = 1'b1;
          par_chk_en = 1'b0;
          stp_chk_en = 1'b0;
          deser_en = 1'b0;
          data_valid = 1'b0;
          next_state = start_bit;
        end else begin
          next_state = idle;
        end

      end

      start_bit: begin
        strt_chk_en = 1'b1;
        if (edge_cnt == 3'b000 && bit_cnt == 4'b1) begin

          if (strt_glitch == 1'b1) begin
            next_state = idle;
          end else if (bit_cnt == 4'b1  ) begin
            enable = 1'b1;
            data_samp_en = 1'b1;
            deser_en = 1'b0;
            data_valid = 1'b0;
            next_state = data_bits;
          end
      
        end 
            else if (bit_cnt == 4'b1011  ) begin
            enable = 1'b1;
            data_samp_en = 1'b1;
            deser_en = 1'b0;
            data_valid = 1'b0;
            next_state = data_bits;
          end
        else begin
          strt_chk_en = 1'b1;
          enable = 1'b1;
          data_samp_en = 1'b1;
          data_valid = 1'b0;
          deser_en = 1'b0;
          next_state = start_bit;
        end
      end

      data_bits: begin
        deser_en = 1'b1;

        if (bit_cnt == 4'b1001) begin
          deser_en = 1'b1;
          if (PAR_EN == 1) begin
            enable = 1'b1;
            data_samp_en = 1'b1;
            par_chk_en = 1'b1;
            data_valid = 1'b0;
            next_state = parity_bit;
          end else begin
            enable = 1'b1;
            data_samp_en = 1'b1;
            stp_chk_en = 1'b1;
            data_valid = 1'b0;
            next_state = stop_bit;
          end

        end else if (edge_cnt == 3'b0) begin

          enable = 1'b1;
          data_samp_en = 1'b1;
          deser_en = 1'b1;
          data_valid = 1'b0;
          next_state = data_bits;

        end else begin

          enable = 1'b1;
          data_samp_en = 1'b1;
          deser_en = 1'b0;
          data_valid = 1'b0;
          next_state = data_bits;

        end

      end

      parity_bit: begin


        if (edge_cnt == 3'b000 && bit_cnt == 4'b1010) begin

          if (par_err == 1) begin
            next_state = idle;
          end else begin
            enable = 1'b1;
            data_samp_en = 1'b1;
            stp_chk_en = 1'b1;
            par_chk_en = 1'b0;
            data_valid = 1'b0;
            next_state = stop_bit;
          end
        end else begin
          enable = 1'b1;
          data_samp_en = 1'b1;
          par_chk_en = 1'b1;
          data_valid = 1'b0;
          next_state = parity_bit;
        end
      end


      stop_bit: begin
        deser_en = 1'b0;
        stp_chk_en = 1'b1;
        if (PAR_EN) begin

          if (edge_cnt == 3'b000 && bit_cnt == 4'b1011) begin

            if (stp_err == 1) begin
              data_valid = 1'b0;
              next_state = idle;
            end else begin

              data_valid = 1'b1;
              next_state = idle;
            end
          end else begin
            enable = 1'b1;
            data_samp_en = 1'b1;
            stp_chk_en = 1'b1;
            next_state = stop_bit;
          end
        end else begin

     /*      if (edge_cnt == 3'b000 && bit_cnt == 4'b1001) begin
          deser_en = 1'b1;
          end
            else if (edge_cnt == 3'b001 && bit_cnt == 4'b1001) begin
          deser_en = 1'b0;
          end
       else */ if (edge_cnt == 3'b000 && bit_cnt == 4'b1010) begin

            if (stp_err == 1) begin
              next_state = idle;
            end else begin

              data_valid = 1'b1;
              next_state = idle;
            end
          end else begin
            enable = 1'b1;
            data_samp_en = 1'b1;
            stp_chk_en = 1'b1;
            data_valid = 1'b0;
            next_state = stop_bit;
          end

        end
      end

      default: begin
        data_samp_en = 1'b0;
        par_chk_en = 1'b0;
        stp_chk_en = 1'b0;
        strt_chk_en = 1'b0;
        enable = 1'b0;
        deser_en = 1'b0;
        data_valid = 1'b0;
        next_state = idle;
      end
    endcase
  end

endmodule
