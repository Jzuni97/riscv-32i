`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2024 12:37:09 AM
// Design Name: 
// Module Name: mem_stage
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


module mem_stage(
    input wire clk,
    input wire [31:0] alu_result,   // address from ALU
    input wire [31:0] write_data,   // data to be written (from rs2)
    input wire [6:0] opcode,        // opcode to determine type of operation
    output wire [31:0] read_data,   // data read from memory
    output wire mem_we              // control signal for memory write
);
    // Define the read enable signal
    wire mem_re;
    
    // Assign operation based on opcode
    assign mem_we = (opcode == 7'b0100011); // enable for store instructions
    assign mem_re = (opcode == 7'b0000011); // enable for load instructions
    
    // Use RAM module
    ram data_memory(
        .clk(clk),
        .mem_we(mem_we),
        .mem_re(mem_re),
        .address(alu_result),
        .write_data(write_data),
        .read_data(read_data)
    );
endmodule
