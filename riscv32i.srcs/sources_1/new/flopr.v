`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/08/2024 11:30:27 PM
// Design Name: 
// Module Name: flopr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//  Resettable flip-flop
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flopr #(parameter WIDTH = 8) (
    input wire clk, reset,
    input wire [WIDTH - 1:0] d,
    output reg [WIDTH - 1:0] q
);
    always @(posedge clk or posedge reset) begin
        if (reset) q <= 0;
        else q <= d;
    end
endmodule
