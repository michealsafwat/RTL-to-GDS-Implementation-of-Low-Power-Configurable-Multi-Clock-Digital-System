module FSM_TX (
    input wire clk,
    input wire rst,
    input wire Data_Valid,
    input wire PAR_EN,
    input wire ser_done,
    output reg [1:0] mux_sel,
    output reg busy,
    output reg ser_en
);


  localparam idle = 3'b000;
  localparam wait_data = 3'b001;
  localparam start = 3'b011;
  localparam data = 3'b111;
  localparam parity = 3'b110;
  localparam stop = 3'b100;

  reg [2:0] current_state, next_state;

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      current_state <= idle;
    end else begin
      current_state <= next_state;
    end
  end

  always @(*) begin
    busy   = 1'b0;
    ser_en = 1'b0;
    mux_sel = 2'b10;
    case (current_state)
      idle: begin
        mux_sel = 2'b10;
        busy = 1'b0;
        ser_en = 1'b0;
        if (Data_Valid) begin
          busy = 1'b1;
          mux_sel = 2'b10;
          ser_en = 1'b0;
          next_state = wait_data;

        end

      end

      wait_data: begin

        ser_en = 1'b0;
        mux_sel = 2'b11;
        busy = 1'b1;
        next_state = start;


        if (!Data_Valid) begin
          ser_en = 1'b0;
          mux_sel = 2'b11;
          busy = 1'b1;
          next_state = start;
        end
      end


      start: begin
        mux_sel = 2'b01;
        ser_en = 1'b1;
        busy = 1'b1;
        next_state = data;
      end

      data: begin

        busy = 1'b1;
        if (ser_done == 1 && PAR_EN == 1) begin
          ser_en = 1'b0;
          mux_sel = 2'b01;
          next_state = parity;

        end else if (ser_done == 1 && PAR_EN == 0) begin
          busy = 1'b1;
          ser_en = 1'b0;
          mux_sel = 2'b01;
          next_state = stop;

        end else begin
          ser_en = 1'b1;
          mux_sel = 2'b01;
          next_state = data;
        end
      end

      parity: begin


        busy = 1'b1;
        mux_sel = 2'b00;
        next_state = stop;


      end
      stop: begin


        if (!Data_Valid) begin
          // ser_en = 1'b0;
          mux_sel = 2'b10;
          busy = 1'b1;
          next_state = idle;
        end

      end
      default: next_state = idle;
    endcase
  end




endmodule
