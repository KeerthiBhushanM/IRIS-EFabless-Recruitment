`timescale 1ns / 1ns
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: Student
// Engineer: Keerthi Bhushan M
// 
// Create Date: 26.05.2023 16:03:15
// Design Name: 
// Module Name: multiplier_tb
// Project Name: Optimised Shift and Add Multiplier
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


module multiplier_tb();
    reg [7:0] A;
    reg [7:0] B;
    reg clk;
    reg reset;
    wire [15:0] prod;
    wire ready;
    
    multiplier M1 (clk, reset, A, B, prod, ready);
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 1;
        reset = 1;#10;
        reset = 0;
        A = 8'b0000_1111; 
        B = 8'b0000_1001;
        #300;
        reset = 1; #20;
        reset = 0;
        A = 8'b0000_1111; 
        B = 8'b0000_1001; 
        #300 $finish;
      end
endmodule
