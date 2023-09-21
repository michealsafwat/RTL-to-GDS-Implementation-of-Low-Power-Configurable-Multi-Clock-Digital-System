module Stop_Check (
    input wire stp_chk_en,
    input wire sampled_bit,
    input wire clk,
    input wire rst,
    output reg stp_err
);
    
always @(posedge clk or negedge rst) begin

if (!rst)
begin
     stp_err <= 1'b0;
end

   else if (stp_chk_en)
    begin
    if (sampled_bit == 1'b1)
    begin
        stp_err <= 1'b0;
    end

  
end

/* else
begin
    stp_err <= 1'b1;
end */

end


endmodule