module CTRL_TX   #(parameter DATA_WIDTH = 8)   (
    
input wire rst,
input wire clk,
input wire Busy,
input wire [2*DATA_WIDTH-1:0] ALU_OUT,
input wire ALU_OUT_VALID,
input wire [DATA_WIDTH-1:0] Rd_DATA,
input wire Rd_DATA_Valid,
output reg [DATA_WIDTH-1:0] TX_P_DATA,
output reg TX_D_VLD


);


localparam IDLE = 3'b000;
localparam ALU0_SEND = 3'b001 ;
localparam ALU1_SEND = 3'b011;
localparam REG_FILE_SEND = 3'b110;

reg [2:0] current_state , next_state;
reg [7:0]TX_P_DATA_2 ;
always @(posedge clk or negedge rst) begin
    if (!rst) begin
      current_state <= IDLE;  
    end
    else
    begin
    current_state <= next_state;
end
end  
always @(*) begin
    
    case(current_state)

    IDLE: begin
        TX_D_VLD = 1'b0;
        TX_P_DATA = 8'b0;
        if (ALU_OUT_VALID )
        begin
            next_state = ALU0_SEND;
        end

        else if (Rd_DATA_Valid) begin
            next_state = REG_FILE_SEND;
        end
else
begin
    next_state = IDLE;
end
    end



REG_FILE_SEND : begin
    if (!Busy)
    begin
        TX_D_VLD = 1'b1;
        TX_P_DATA = Rd_DATA;
        next_state = IDLE;
    end
    else
    begin
        TX_D_VLD = 1'b0;
        TX_P_DATA = 8'b0;
        next_state = IDLE;  
    end
end

ALU0_SEND : begin
    if (!Busy)
    begin
        TX_D_VLD = 1'b1;
        TX_P_DATA = ALU_OUT[7:0];
         TX_P_DATA_2 = ALU_OUT[15:8];
        next_state = ALU1_SEND;
    end
    else
    begin
        TX_D_VLD = 1'b0;
        TX_P_DATA = 8'b0;
        next_state = IDLE;  
    end
end
ALU1_SEND : begin
    if (!Busy)
    begin
        TX_D_VLD = 1'b1;
        TX_P_DATA = TX_P_DATA_2;
        next_state = IDLE;
    end
    else
    begin
        TX_D_VLD = 1'b0;
        TX_P_DATA = 8'b0;
        next_state = IDLE;  
    end
end

default: begin
      TX_D_VLD = 1'b0;
        TX_P_DATA = 8'b0;
        next_state = IDLE;  
end
endcase
end

endmodule