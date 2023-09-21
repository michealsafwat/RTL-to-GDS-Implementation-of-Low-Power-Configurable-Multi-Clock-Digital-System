module DATA_SYNC #(parameter BUS_WIDTH = 8, NUM_STAGES= 8) (

input wire [BUS_WIDTH-1:0] Unsync_bus,
input wire bus_enable,
input wire CLK,
input wire RST,
output reg [BUS_WIDTH-1:0] sync_bus,
output reg enable_pulse
);

wire pulse_gen_in;
wire mux_sel;
reg Q;
reg [BUS_WIDTH-1:0] mux_out;
assign mux_sel = pulse_gen_in && ~Q;
reg [NUM_STAGES+3:1]FF;
always @(posedge CLK or negedge RST) begin
 if (!RST)
 begin
    FF <=  0;
 end
else
begin
  Q <= pulse_gen_in;
    FF <= {FF[NUM_STAGES+2:1],bus_enable} ;
enable_pulse <= mux_sel;
sync_bus <= mux_out;
end
end

  assign   pulse_gen_in = FF[NUM_STAGES+2];

  always @(*) begin
    if (mux_sel)
    begin
        mux_out = Unsync_bus;
    end

    else
    begin
        mux_out = sync_bus;
    end
  end
endmodule