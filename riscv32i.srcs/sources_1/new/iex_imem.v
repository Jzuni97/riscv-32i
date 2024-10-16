`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2024 11:38:20 AM
// Design Name: 
// Module Name: iex_imem
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


module iex_imem(
    input wire clk,
    input wire reset,
    
    // Inputs
    input wire [31:0] alu_resultE,
    input wire [31:0] write_dataE,
    input wire [4:0] rdE,
    input wire [31:0] pc_plus4E,
    // Outputs
    output reg [31:0] alu_resultM,
    output reg [31:0] write_dataM,
    output reg [4:0] rdM,
    output reg [31:0] pc_plus4M
);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            alu_resultM <= 32'b0;
            write_dataM <= 32'b0;
            rdM <= 5'b0;
            pc_plus4M <= 32'b0;
        end
        else begin
            alu_resultM <= alu_resultE;
            write_dataM <= write_dataE;
            rdM <= rdE;
            pc_plus4M <= pc_plus4E;
        end
    end
endmodule
