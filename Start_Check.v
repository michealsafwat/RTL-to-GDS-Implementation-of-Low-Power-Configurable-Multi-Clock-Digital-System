module Start_Check (
      input wire strt_chk_en,
    input wire sampled_bit,
    input wire clk,
    input wire rst,

    output reg strt_glitch
);
    always @(posedge clk or negedge rst) begin

if (!rst)
begin
     strt_glitch <= 1'b0;
end

else if (strt_chk_en)
    begin
    if (sampled_bit == 1'b0)
    begin
        strt_glitch <= 1'b0;
    end

   
end



end
endmodule