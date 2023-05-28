`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2023 02:25:17
// Design Name: 
// Module Name: Dff
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


module Dff(
    input wire clk,         // Clock input
    input wire reset,       // Asynchronous active-low reset input
    input wire d,           // Data input
    output reg q            // Output
);

    always @(posedge clk or negedge reset)
    begin
        if (!reset)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
