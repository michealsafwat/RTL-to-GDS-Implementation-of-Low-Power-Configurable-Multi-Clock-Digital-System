module edge_bit_counter (
    input wire clk,
    input wire rst,
    input wire enable,
    output reg [3:0] bit_cnt,
    output reg [2:0] edge_cnt  
);
    

always @(posedge clk or negedge rst) begin
    if (!rst)
    begin
        bit_cnt <= 4'b0;
        edge_cnt <= 3'b0;
    end

    else if (enable)
    begin
        edge_cnt <= edge_cnt + 3'b1;
        if (edge_cnt == 3'b111)
        begin
            bit_cnt <= bit_cnt + 4'b1;
        end
        if (bit_cnt == 4'b1011)
begin
    bit_cnt <= 4'b0;
end
    end  



end



endmodule