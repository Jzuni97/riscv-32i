`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2024 08:27:29 PM
// Design Name: 
// Module Name: imm_extend
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


module imm_extend(
    input wire [31:0] instr,    // fetched instruction
    input wire [1:0] imm_src,   // control signal from main-controller
    output reg [31:0] imm_ext   // the sign-extended immediate
);

    always @(*) begin
        case (imm_src)
            // I-Type
            2'b00: imm_ext = { {20{instr[31]}}, instr[31:20] }; // (base & load & jalr)
            // S-Type
            2'b01: imm_ext = { {20{instr[31]}}, instr[31:25], instr[11:7] }; // (store)
            // B-Type
            2'b10: imm_ext = { {19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:6], 1'b0 }; // (branch)
            // J-Type
            2'b11: imm_ext = { {11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0 }; // (jump)
            // undefined imm_src
            default: imm_ext = 32'b0;
        endcase
    end
endmodule
