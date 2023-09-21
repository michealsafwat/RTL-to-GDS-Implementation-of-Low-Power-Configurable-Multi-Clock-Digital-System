module BIT_SYNC #(parameter BUS_WIDTH =1,parameter NUM_STAGES = 5) (
    input wire clk,
    input wire rst,
    input wire ASYNC,
    output wire SYNC
);
    



reg [NUM_STAGES+1:1]FF;

integer i = 0;
genvar  j ;

always @(posedge clk or negedge rst) begin
 if (!rst)
 begin
    FF <=  0;
 end
else
begin
    for (i=0; i<BUS_WIDTH; i=1+i)
    begin
    FF <= {FF[NUM_STAGES:1],ASYNC};
end  

end
end

    for ( j=0; j<BUS_WIDTH; j=1+j)
    begin
  assign   SYNC = FF[NUM_STAGES+1];
end

endmodule