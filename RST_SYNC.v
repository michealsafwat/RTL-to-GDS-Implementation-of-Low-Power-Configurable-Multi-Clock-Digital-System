module RST_SYNC #(parameter NUM_STAGES=2 )(
    input wire RST,
    input wire CLK,
    output wire SYNC_RST
);


reg [NUM_STAGES+1:1]FF;

always @(posedge CLK or negedge RST ) begin
    if(!RST)
    begin
       FF <= 0; 
    end
else
begin
  
    FF <= {FF[NUM_STAGES:1],1'b1} ;

end
end

  assign   SYNC_RST = FF[NUM_STAGES+1];



endmodule