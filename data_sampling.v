module data_sampling (
    input wire [2:0] prescale,
    input wire clk,
    input wire rst,
    input wire RX_IN,
    input wire data_samp_en,
    input wire [2:0] edge_cnt,
    output reg sampled_bit
);

reg [1:0] ones = 2'b0 ;
reg [1:0] zeros = 2'b0 ;

always @(posedge clk or negedge rst) begin
    if(!rst)
    begin
        sampled_bit <= 1'b1;
        ones <= 2'b0;
         zeros <=  2'b0;
    end
else if (data_samp_en)
begin
    if (edge_cnt == 3'b011 || edge_cnt == 3'b100 || edge_cnt == 3'b101 )
    begin
        if (RX_IN == 1'b1)
        begin
            ones <= ones + 2'b1;
        end
        else 
        begin
           zeros <= zeros + 2'b1;  
        end
    end

    if (edge_cnt == 3'b111)
    begin
        sampled_bit <= (ones > zeros) ? 1'b1 : 1'b0;
         ones <= 2'b0;
         zeros <=  2'b0;
    end
end



end

    
endmodule