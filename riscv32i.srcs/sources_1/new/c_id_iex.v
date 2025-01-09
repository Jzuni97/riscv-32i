`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2025 12:03:16 AM
// Design Name: 
// Module Name: c_id_iex
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//  Controller pipeline register between IDecode and IExecute
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module c_id_iex(
    input wire clk, reset,

    input wire [1:0] result_srcD,
    input wire [3:0] alu_controlD,
    input wire alu_srcD,
    input wire reg_writeD,
    input wire mem_writeD,
    input wire branchD,
    input wire jumpD,
    
    output reg [1:0] result_srcE,
    output reg [3:0] alu_controlE,
    output reg alu_srcE,
    output reg reg_writeE,
    output reg mem_writeE,
    output reg branchE,
    output reg jumpE
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result_srcE <= 0;
            alu_controlE <= 0;
            alu_srcE <= 0;
            reg_writeE <= 0;
            mem_writeE <= 0;
            branchE <= 0;
            jumpE <= 0;
        end
        else begin
            result_srcE <= result_srcD;
            alu_controlE <= alu_controlD;
            alu_srcE <= alu_srcD;
            reg_writeE <= reg_writeD;
            mem_writeE <= mem_writeD;
            branchE <= branchD;
            jumpE <= jumpD;
        end
    end

endmodule
