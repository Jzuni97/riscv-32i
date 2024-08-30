`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2024 12:22:44 AM
// Design Name: 
// Module Name: ram
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


module ram(
    input wire clk,                 // system clock
    input wire mem_we,              // write enable
    input wire mem_re,              // read enable
    input wire [31:0] address,      // address for memory address
    input wire [31:0] write_data,   // data to be written to memory
    output reg [31:0] read_data     // data read from memory
);
    // Memory definition (4kB)
    reg [31:0] ram[1023:0];
    
    // Write operation
    always @(posedge clk) begin
        if (mem_we)
            ram[address[11:2]] <= write_data;
    end
    
    // Read operation
    always @(*) begin
        if (mem_re)
            read_data = ram[address[11:2]];
        else
            read_data = 32'b0;
    end
endmodule
