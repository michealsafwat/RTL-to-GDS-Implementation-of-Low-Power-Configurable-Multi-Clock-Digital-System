module serializer (
    input wire clk,
    input wire rst,
    input wire Data_Valid,
    input wire [7:0] P_DATA,
   input wire ser_en,
   input wire busy,
    output wire ser_done,
    output wire ser_data
    
   
    
);
    
reg [7:0] DATA;
reg [2:0]ser_count ;
always @(posedge clk or negedge rst) begin

    if(!rst)
    begin


DATA <= 8'b0;

    end


else if (Data_Valid && !busy)
begin
 
    DATA <= P_DATA; 
  
end
else if(Data_Valid && busy )
begin
   DATA <= P_DATA; 
   
end

 else if (ser_en)
 begin
    DATA <= DATA>>1;
 end


end

always @(posedge clk or negedge rst) begin
    
    if(!rst)
    begin

ser_count <=3'b0;


    end

else if (!ser_en)
begin
ser_count <=3'b0;

end

else 
begin
    
    ser_count <= ser_count +3'b1;
    
end

end 

assign ser_done = (ser_count == 3'b111) ? 1'b1 : 1'b0 ;
assign ser_data = DATA[0];

endmodule