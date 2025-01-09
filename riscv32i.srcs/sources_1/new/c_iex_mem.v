`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2025 12:03:16 AM
// Design Name: 
// Module Name: c_iex_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//  Controller pipeline register between IExecute and IMem
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module c_iex_mem(
    input wire clk, reset,
    
    input wire [1:0] result_srcE,
    input wire reg_writeE, mem_writeE,
    
    output reg [1:0] result_srcM,
    output reg reg_writeM, mem_writeM
);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result_srcM <= 0;
            reg_writeM <= 0;
            mem_writeM <= 0;
        end
        else begin
            result_srcM <= result_srcE;
            reg_writeM <= reg_writeE;
            mem_writeM <= mem_writeE;
        end
    end

endmodule
