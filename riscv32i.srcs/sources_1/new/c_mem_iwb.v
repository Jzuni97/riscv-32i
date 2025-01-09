`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/09/2025 12:03:16 AM
// Design Name: 
// Module Name: c_mem_iwb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//  Controller pipeline register between IMem and IWrite
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module c_mem_iwb(
    input wire clk, reset,
    
    input wire [1:0] result_srcM,
    input wire reg_writeM,
    
    output reg [1:0] result_srcW,
    output reg reg_writeW
);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            result_srcW <= 0;
            reg_writeW <= 0;
        end
        else begin
            result_srcW <= result_srcM;
            reg_writeW <= reg_writeM;
        end
    end
    
endmodule
