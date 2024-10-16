`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2024 11:38:20 AM
// Design Name: 
// Module Name: imem_iwb
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


module imem_iwb(
    input wire clk,
    input wire reset,
    
    // Inputs
    input wire [31:0] alu_resultM,
    input wire [31:0] mem_dataM,
    input wire [4:0] rdM,
    input wire [31:0] pc_plus4M,
    // Outputs
    output reg [31:0] alu_resultW,
    output reg [31:0] mem_dataW,
    output reg [4:0] rdW,
    output reg [31:0] pc_plus4W
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            alu_resultW <= 32'b0;
            mem_dataW <= 32'b0;
            rdW <= 5'b0;
            pc_plus4W <= 32'b0;
        end
        else begin
            alu_resultW <= alu_resultM;
            mem_dataW <= mem_dataM;
            rdW <= rdM;
            pc_plus4W <= pc_plus4M;
        end
    end
endmodule
