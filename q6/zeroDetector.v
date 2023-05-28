`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2023 01:18:16
// Design Name: 
// Module Name: zero_detector
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


module zero_detector(
    input wire clk,      
    input wire reset,    
    input wire i_seq,
    output reg result,
    output reg [1:0] state
);

    parameter S0=0,S1=1,S2=2;     //S0 = no zero detected, S1 = one zero detected, S2 = two zero detected
    reg [1:0] nextState;
    reg o_detected;
        
    always @(posedge clk, posedge reset, i_seq)
    begin
        if (reset) begin
            state <= S0;
            result <= 0;
        end
        else begin
            state <= nextState;
            result <= o_detected;
        end
    end
            
    always @(state, i_seq)
    begin
        case (state)
            S0:begin
                if(i_seq) begin
                    nextState <= S0;
                    o_detected <= 0;
                end
                else begin
                    nextState <= S1;
                    o_detected <= 0;
                end
            end
            S1:begin
                if(i_seq) begin
                    nextState <= S1;
                    o_detected <= 0;
                end
                else begin
                    nextState <= S2;
                    o_detected <= 1;
                end
            end
            S2:begin
                nextState <= S0;
                o_detected <= 1;
            end
        endcase
    end

endmodule
