`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2024 11:35:27 PM
// Design Name: 
// Module Name: regfile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//  3-port register file
//  read two ports combinationally (rs1/rd1, rs2/rd2)
//  write third port on rising edge of clock (rd/wd/we)
//  register x0 hardwired to zero.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module regfile(
    input wire clk,
    input wire we,
    input wire [31:0] wd, // Write data
    input wire [31:0] rd1, rd2, // Read data 1 & 2
    input wire [4:0] rs1, rs2, rd // Read sources 1 & 2, and destination
);
    // 32 Registers, each 32 bits wide
    reg [31:0] regs[31:0];
    integer i;
    
    // Initialize all registers to zero
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
           regs[i] = 32'b0; 
        end
    end
    
    // Read logic (async)
    assign rd1 = (rs1 == 5'b00000) ? 32'b0 : regs[rs1];
    assign rd1 = (rs2 == 5'b00000) ? 32'b0 : regs[rs2];
    
    // Write logic (sync)
    always@(posedge clk) begin
        if (we && rd != 5'b00000) begin // ignore write to x0
            regs[rd] <= wd;
        end
    end
     
endmodule
