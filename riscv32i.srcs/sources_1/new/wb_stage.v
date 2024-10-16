`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2024 06:10:56 PM
// Design Name: 
// Module Name: wb_stage
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


module wb_stage(
    input wire clk,
    input wire rst,
    input wire [31:0] alu_result,
    input wire [31:0] mem_read_data,
    input wire [4:0] rd,                // destination register address
    input wire reg_we_in,               // control signal: write enable
    input wire mem_to_reg,              // control signal: select memory or ALU
    output wire [31:0] write_data,      // data to write back to reg file
    output wire [4:0] write_addr,       // destination register address
    output wire reg_write_enable_out    // control signal: write enable propagated
);
endmodule
