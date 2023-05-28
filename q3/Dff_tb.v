`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2023 02:27:31
// Design Name: 
// Module Name: Dff_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Dff_tb;
  reg clk;
  reg reset;
  reg d;
  wire q;

  Dff dut (clk, reset, d, q);

  // Clock generation
  always begin
    clk = ~clk; #5;
  end

  // Stimulus generation and reset assertion
  initial begin
    clk = 1;
    reset = 0;
    d = 1;
    #15;
    reset = 1;
    #10;
    d = 1;
    #10;
    d = 0;
    #10;
    d = 1;
    #10;
    reset = 0;
    d = 1;
    #20;
    $finish;
  end
endmodule
