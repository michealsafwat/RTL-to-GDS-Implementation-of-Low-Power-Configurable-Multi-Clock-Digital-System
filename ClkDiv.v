module ClkDiv  #(parameter RATIO = 4)(
    input wire i_ref_clk,
    input wire i_rst_n,
    input wire i_clk_en,
    input [RATIO-1:0] i_div_ratio,
    output reg o_div_clk

);

reg [2:0] counter = 3'b0;
reg high = 0;
reg flag=0;
reg divided_clk=0;
always @(posedge i_ref_clk or negedge i_rst_n) begin
  
    if (!i_rst_n )
    begin
        counter <= 3'b0;
        o_div_clk <= 0;
    end

   else if (i_clk_en)
   begin
    if(counter == (i_div_ratio >> 1) && !high )
        begin
        divided_clk <= ~divided_clk;
         counter <= 3'b0;
         high <=1;
        end

          else if ((counter == ((i_div_ratio >> 1)-1) && i_div_ratio[0]==1)&& high || ( counter == ((i_div_ratio >> 1)-1) && i_div_ratio[0]==0))
        begin
            divided_clk <= ~divided_clk;
         counter <= 3'b0;
         high = 0;
        end

else 
begin
    counter <= counter+3'b1;
end
   


    end  
end 

always @(*) begin
   
   if (i_clk_en)
   begin
    o_div_clk <= divided_clk;
    end

    else 
    begin
        o_div_clk <= i_ref_clk;
    end
    
end

endmodule