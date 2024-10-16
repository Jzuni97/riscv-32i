`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2024 11:38:20 AM
// Design Name: 
// Module Name: if_id
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// TODO:
//  Consider adding a sync clear and enable signal
//  I believe these come from the hazard unit
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module if_id(
    input wire clk,
    input wire reset,
    
    input wire [31:0] instrF, pcF, pc_plus4F,
    output reg [31:0] instrD, pcD, pc_plus4D
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            instrD <= 0;
            pcD <= 0;
            pc_plus4D <= 0;
        end
        else begin
            instrD <= instrF;
            pcD <= pcD;
            pc_plus4D <= pc_plus4F;
        end
    end
endmodule
