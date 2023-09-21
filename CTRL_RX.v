module CTRL_RX #( parameter FUN_WIDTH = 4,  parameter WIDTH = 8, DEPTH = 16, ADDR = 4)
   
 (
    input wire clk,
    input wire rst,
    input wire RX_D_VLD,
    input wire [WIDTH-1:0] RX_P_DATA,
    output reg [FUN_WIDTH-1:0] FUN,
    output reg EN,
    output reg WrEn,
    output reg RdEn,
    output reg Gate_EN,
    output reg [ADDR-1:0] Addr,
    output reg [WIDTH-1:0] Wr_D
);

  localparam IDLE = 4'b0000;
  localparam REC_OP_A = 4'b0001;
  localparam REC_OP_B = 4'b0011;
  localparam REC_CMD = 4'b0111;
  localparam CMD_DECODE = 4'b1111;
  localparam Rd_Addr = 4'b1110;
  localparam Wr_Addr = 4'b0110;
  localparam ALU_FUNC = 4'b0100;
  localparam Wr_DATA = 4'b1100;
localparam Wait_Addr = 4'b1101;
localparam Wait_Data_Write = 4'b0101;
localparam Wait_FUNC = 4'b0010;
  reg [3:0] current_state, next_state;

  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      current_state <= IDLE;
    end else begin
      current_state <= next_state;
    end
  end

  always @(*) begin
    case (current_state)
      IDLE: begin
        FUN  = 4'b0;
        EN   = 1'b0;
        WrEn = 1'b0;
        RdEn = 1'b0;
        Addr = 4'b0;
        Wr_D = 8'b0;

        if (RX_D_VLD) begin
          next_state = CMD_DECODE;
        end else begin
          next_state = IDLE;
        end
      end

      CMD_DECODE: begin
        FUN  = 4'b0;
        EN   = 1'b0;
        WrEn = 1'b0;
        RdEn = 1'b0;
        Addr = 4'b0;
        Wr_D = 8'b0;

        case (RX_P_DATA)
          8'hAA: begin
            next_state = Wait_Addr;
          end

          8'hBB: begin
            next_state = Rd_Addr;
          end

          8'hCC: begin
            next_state = REC_OP_A;
          end

          8'hDD: begin
            next_state = Wait_FUNC;
          end

          default: begin
            next_state = IDLE;
          end
        endcase
      end

Wait_Addr : begin
        Addr = 4'b0;
        FUN = 4'b0;
        EN = 1'b0;
        WrEn = 1'b0;
        RdEn = 1'b0;
        Wr_D = 8'b0;
if(RX_D_VLD)
begin
   next_state = Wr_Addr;
end

else
begin
  next_state = Wait_Addr;
end
 
end


      Wr_Addr: begin
        Addr = RX_P_DATA;
        FUN = 4'b0;
        EN = 1'b0;
        WrEn = 1'b0;
        RdEn = 1'b0;
        Wr_D = 8'b0;
        next_state = Wait_Data_Write;
      end

Wait_Data_Write : begin
        Addr = 4'b0;
        FUN = 4'b0;
        EN = 1'b0;
        WrEn = 1'b0;
        RdEn = 1'b0;
        Wr_D = 8'b0;
        if(RX_D_VLD)
begin
   next_state = Wr_DATA;
end

else
begin
  next_state = Wait_Data_Write;
end
end


      Wr_DATA: begin
        Wr_D = RX_P_DATA;
        FUN = 4'b0;
        EN = 1'b0;
        WrEn = 1'b1;
        RdEn = 1'b0;
        next_state = IDLE;
      end

      Rd_Addr: begin
        Addr = RX_P_DATA;
        RdEn = 1'b1;
        Wr_D = 8'b0;
        FUN = 4'b0;
        EN = 1'b0;
        WrEn = 1'b0;
        next_state = IDLE;
      end

      REC_OP_A: begin
        Addr = 4'h0;
        RdEn = 1'b0;
        Wr_D = RX_P_DATA;
        FUN = 4'b0;
        EN = 1'b0;
        WrEn = 1'b1;
        next_state = REC_OP_B;
      end

      REC_OP_B: begin

        Addr = 4'h1;
        RdEn = 1'b0;
        Wr_D = RX_P_DATA;
        FUN = 4'b0;
        EN = 1'b0;
        WrEn = 1'b1;
        next_state = ALU_FUNC;
      end


Wait_FUNC : begin
   Addr = 4'b0;
        FUN = 4'b0;
        EN = 1'b0;
        WrEn = 1'b0;
        RdEn = 1'b0;
        Wr_D = 8'b0;
        if(RX_D_VLD)
begin
   next_state = ALU_FUNC;
end

else
begin
  next_state = Wait_FUNC;
end
end

      ALU_FUNC: begin
        Addr = 1'b0;
        RdEn = 1'b0;
        Wr_D = 8'b0;
        FUN = RX_P_DATA;
        EN = 1'b1;
        Gate_EN = 1'b1;
        WrEn = 1'b0;
        next_state = IDLE;
      end

    endcase

  end


endmodule
