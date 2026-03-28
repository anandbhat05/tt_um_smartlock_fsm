`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Dump waveform
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  // Signals
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Instantiate YOUR module (changed name here)
  tt_um_smart_lock user_project (

`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),
      .uo_out (uo_out),
      .uio_in (uio_in),
      .uio_out(uio_out),
      .uio_oe (uio_oe),
      .ena    (ena),
      .clk    (clk),
      .rst_n  (rst_n)
  );

  // Clock generation (10ns period)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Basic stimulus
  initial begin
    // Initialize
    ena   = 1;
    rst_n = 0;
    ui_in = 8'b0;
    uio_in = 8'b0;

    #10;
    rst_n = 1;

    // Test sequence: 1 0 1 1 (correct password)
    #10 ui_in[0] = 1;
    #10 ui_in[0] = 0;
    #10 ui_in[0] = 1;
    #10 ui_in[0] = 1;

    // Wait to observe unlock
    #20;

    // Wrong sequence test
    #10 ui_in[0] = 1;
    #10 ui_in[0] = 1;
    #10 ui_in[0] = 0;

    #50;
    $finish;
  end

endmodule
