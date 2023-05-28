`timescale 1ns / 1ns
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2023 16:03:15
// Design Name: 
// Module Name: multiplier_tb
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


module zeroDetector_tb();
    reg clk;
    reg reset;
    reg i_seq;
    wire o_detected;
    wire [1:0] state;
    
    zero_detector dut (clk, reset, i_seq, o_detected, state);
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 1;
        i_seq = 1;
        #10;
        reset = 1;#5;
        reset = 0;
        i_seq = 1; #10;
        i_seq = 0; #10;
        i_seq = 1; #10;
        reset = 1;#10;
        reset =0;
        i_seq = 1; #10;
        i_seq = 0; #10;
        i_seq = 0; #10;
        reset =1;
        
        #300 $finish;
      end
endmodule
