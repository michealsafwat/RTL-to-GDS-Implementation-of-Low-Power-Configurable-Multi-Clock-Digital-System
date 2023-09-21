module Parity_Check (
    input wire sampled_bit,
    input wire par_chk_en,
    input wire par_bit,
    input wire clk,
    input wire rst,
    output reg par_err
);
    
always @(posedge clk or negedge rst) begin
if (!rst)
begin
    par_err = 1'b0;
end
  else  if (par_chk_en)
    begin
        if (par_bit == sampled_bit)
        begin
            par_err = 1'b0;
        end

      
    end

    
end


endmodule