`timescale 1ns / 1ns
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: Student
// Engineer: Keerthi Bhushan M
// 
// Create Date: 23.05.2023 19:52:44
// Design Name: 
// Module Name: multiplier
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

module ShiftRegister(
    input wire clk,    // Clock input
    input wire reset,  // Reset input
    input wire shift,  // Shift input
    input wire data_in,// Shift Data input
    input wire load,   // Load input
    input wire [7:0] load_data, // Load data input
    output wire [7:0] reg_out // Data output
);
    reg [7:0] register;
    always @(posedge clk or negedge reset or posedge load) begin
        if (reset)
            register <= 8'b0000_0000; // Reset the register to 0
        else if (shift)
            register <= {data_in, register[7:1]}; // Shift right and input data at LSB
        else if(load)
            register <= load_data;
    end
    
    assign reg_out = register;
endmodule

module ALU_Adder(
    input wire [7:0] operand_a,   // Input operand A (8-bit)
    input wire [7:0] operand_b,   // Input operand B (8-bit)
    input wire enable,            // Enable signal
    output wire [7:0] result      // Result (8-bit, excluding carry)
);
    reg [8:0] sum;  // 9-bit register to hold the sum

    always @(operand_a, operand_b, enable) begin
        if (enable)
            sum <= operand_a + operand_b;  // Perform addition
        else
            sum <= operand_a;                   // Set sum to 0 when not enabled
    end
    
    assign result = sum;
endmodule

module ControlUnit(
    input wire clk, 
    input wire reset,
    input wire i_Q0,
    output reg o_add,
    output reg o_load,
    output reg o_shift,
    output reg o_write,
    output reg o_ready,
    output reg [2:0] state
);
    reg [2:0] nextState;
    reg [3:0] count;
    parameter S_idle=0, S_add=1, S_write=2, S_shift=3, S_ready=4;
    
    always @ (posedge clk or negedge reset) begin: State_transitions
        if (reset) 
            state <= S_idle; 
        else 
            state <= nextState; 
    end
    
     always @ (state) begin: Output_and_next_state 
        o_add=0;    o_shift=0;  o_write=0;  o_load=0;   
        
        case(state)
            S_idle: begin
                count = 8;

                    nextState = S_add;
                     o_load = 1;
                     o_ready=0;
            end
            S_add: begin
                nextState = S_write;
                o_add = 1;
                
            end
            S_write: begin
                nextState = S_shift;
                if(i_Q0 == 1'b1)
                    o_write = 1;
            end
            S_shift: begin    
                o_shift = 1;
                count = count - 1;
                if (count==0) 
                begin
                    nextState = S_ready;
                    o_ready = 1;
                end
                else nextState = S_add;
            end
            S_ready: begin
                nextState = S_ready;
            end
        endcase
     end
endmodule

module multiplier(
    input wire clk,
    input wire reset,
    input wire [7:0] multiplier,
    input wire [7:0] multiplicand,
    output reg [15:0] product,
    output wire o_Ready
);
    wire Load_A, Load_B, Load_Q;
    wire [2:0] state;
    wire [7:0] SReg_A_out, SReg_B_out, SReg_Q_out, ALU_out;
    wire  C_add, C_load, C_shift, C_write;
    
    ControlUnit C1 (clk, reset, SReg_Q_out[0], C_add, C_load, C_shift, C_write, o_Ready, state);
    
    ShiftRegister A (clk, reset, C_shift, 1'b0, C_write, ALU_out, SReg_A_out);
    ShiftRegister B (clk, reset, 1'b0, 1'b0, C_load, multiplicand, SReg_B_out);
    ShiftRegister Q (clk, reset, C_shift, SReg_A_out[0], C_load, multiplier, SReg_Q_out);
    
    ALU_Adder ALU (SReg_A_out, SReg_B_out, C_add, ALU_out);
    
    always@* 
    begin
    product = {SReg_A_out,SReg_Q_out};
    end
endmodule
