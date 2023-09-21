module Parity_Calc (
    input wire clk,
    input wire rst,
    input wire PAR_TYP,
    input wire [7:0] P_DATA,
    input wire Data_Valid,
    output reg par_bit
);

always @(posedge clk or negedge rst) begin

if (!rst)
begin
    par_bit <=0;
  
end    

else if (Data_Valid)
begin
  if (PAR_TYP == 0) 
begin

    par_bit <= ^P_DATA;

end
else 
begin
    par_bit <= ~^P_DATA;
end
 
end


end



endmodule