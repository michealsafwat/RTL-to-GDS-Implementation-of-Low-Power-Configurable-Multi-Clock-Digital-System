`timescale 1ns / 100ps
module UART_TX_tb ();

  reg clk_tb;
  reg rst_tb;
  reg Data_Valid_tb;
  reg PAR_EN_tb;
  reg [7:0] P_DATA_tb;
  reg PAR_TYP_tb;
  wire busy_tb;
  wire TX_OUT_tb;

  parameter CLK_PERIOD = 5;

  initial begin

    $dumpfile("UART_TX.vcd");
    $dumpvars;
    initialize();
    reset();
    P_DATA_tb = 8'b00000001;
    Data_Valid_tb = 1'b1;
    PAR_EN_tb = 1'b1;
    PAR_TYP_tb = 1'b0;
    #CLK_PERIOD Data_Valid_tb = 1'b0;

    // P_DATA_tb = 8'b11100011;
    // Data_Valid_tb = 1'b1;
    // PAR_EN_tb = 1'b0;
    // PAR_TYP_tb =1'b0;
    // #CLK_PERIOD
    // Data_Valid_tb = 1'b0;
    #(20 * CLK_PERIOD) $stop;
  end




  task initialize();
    begin
      clk_tb = 1'b0;
      Data_Valid_tb = 1'b0;
      PAR_EN_tb = 1'b0;
      P_DATA_tb = 8'b0;
      PAR_TYP_tb = 1'b0;
    end
  endtask

  task reset();
    begin
      rst_tb = 1'b1;
      #CLK_PERIOD rst_tb = 1'b0;
      #2.5
    rst_tb = 1'b1;
    end
  endtask

  UART_TX DUT (
      .clk(clk_tb),
      .rst(rst_tb),
      .Data_Valid(Data_Valid_tb),
      .PAR_EN(PAR_EN_tb),
      .P_DATA(P_DATA_tb),
      .PAR_TYP(PAR_TYP_tb),
      .busy(busy_tb),
      .TX_OUT(TX_OUT_tb)
  );



  always #2.5 clk_tb = ~clk_tb;

endmodule
