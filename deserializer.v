module deserializer (
    input wire clk,
    input wire rst,
    input wire deser_en,
    input wire PAR_TYP,
    input wire PAR_EN,
    input wire data_valid,
    input wire sampled_bit,
     input   wire   [2:0]            edge_cnt, 
    output wire [7:0] P_DATA ,
    output reg par_bit
);
    
reg [7:0] DATA = 8'b0 ;
  reg [2:0] i = 3'b0 ;
always @(posedge clk or negedge rst) begin

     if(!rst)
   begin
DATA <= 'b0 ;
   end
  else if(deser_en && !data_valid)
   begin
   // P_DATA <= {sampled_bit,P_DATA[7:1]}	;
     DATA[i] <= sampled_bit;
    i <= i+ 3'b1;
        
   end	
   if(data_valid)
    begin
        DATA <= 'b0 ;
       i <= 3'b0;
    end


/* 
else  if (deser_en && !data_valid)
begin
   
    DATA[i] <= sampled_bit;
    i <= i+ 3'b1;
     
end



else if (data_valid)
begin
     DATA <= 8'b0;
        i <= 3'b0;
end

 P_DATA <= (data_valid) ? DATA : 8'b0;
 flag <= (P_DATA == DATA) ? 1'b1 : 1'b0;
 par_bit <= (flag == 1 && PAR_EN == 1) ? (PAR_TYP == 0) ? ^P_DATA : ~^P_DATA : 1'b0; */


end

 assign P_DATA = (data_valid) ? DATA : 8'b0;


endmodule
/*module deserializer (

    input wire clk,

    input wire rst,

    input wire deser_en,

    input wire PAR_TYP,

    input wire PAR_EN,

    input wire data_valid,

    input wire sampled_bit,

    output wire [7:0] P_DATA ,

    output wire par_bit

);

    

reg [2:0] i;

reg [7:0] DATA ;

wire flag;

always @(posedge clk or negedge rst) begin

    if(!rst)

    begin

        DATA <= 8'b0;

        i <= 3'b0;

       

    end

else if (deser_en && !data_valid)

begin

    DATA[i] <= sampled_bit;

    i <= i+ 3'b1;

end









end



assign P_DATA = (data_valid) ? DATA : 8'b0;

assign flag = (P_DATA == DATA) ? 1'b1 : 1'b0;

assign par_bit = (flag == 1 && PAR_EN == 1) ? (PAR_TYP == 0) ? ^P_DATA : ~^P_DATA : 1'b0;





endmodule
*/