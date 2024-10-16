`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2024 11:38:20 AM
// Design Name: 
// Module Name: id_iex
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


module id_iex(
    input wire clk,
    input wire reset,
    
    // Inputs
    input wire [31:0] rd1D, rd2D,
    // NOTE FROM BOOK:
    // One of the subtle but critical issues in pipelining is that all signals associated with an instruction
    //  must advance through the pipeline in unison.
    // During writeback the result comes from the writeback stage, but the destination register comes from decode stage.
    // To fix this issue, the destination register must be pipelined along execution, mem, writeback so it remains in sync with the original instruction.
    input wire [4:0] rdD,
    input wire [4:0] rs1D, rs2D,
    input wire [31:0] imm_extD,
    input wire [31:0] pcD, pc_plus4D,
    
    // Outputs
    output reg [31:0] rd1E, rd2E,
    output reg [4:0] rdE,
    output reg [4:0] rs1E, rs2E,
    output reg [31:0] imm_extE,
    output reg [31:0] pcE, pc_plus4E
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            rd1E <= 32'b0;
            rd2E <= 32'b0;
            rdE <= 5'b0;
            rs1E <= 5'b0;
            rs2E <= 5'b0;
            imm_extE <= 32'b0;
            pcE <= 32'b0;
            pc_plus4E <= 32'b0;
        end
        else begin
            rd1E <= rd1D;
            rd2E <= rd2D;
            rdE <= rdD;
            rs1E <= rs1D;
            rs2E <= rs2D;
            imm_extE <= imm_extD;
            pcE <= pcD;
            pc_plus4E <= pc_plus4D;
        end
    end
endmodule
