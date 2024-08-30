`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2024 02:53:24 PM
// Design Name: 
// Module Name: id_stage
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


module id_stage(
    input wire [31:0] pc,               // current pc
    input wire [31:0] instr,            // fetched instruction
    input wire [31:0] reg_data1,        // data from register 1
    input wire [31:0] reg_data2,        // data from register 2
    // decoded values
    output reg [31:0] imm,              // signed-extended immediate value
    output reg [31:0] rs1, rs2, rd,     // register addresses
    output reg [31:0] opcode,           // opcode of the instruction
    output reg [31:0] funct3,           // function 3 field
    output reg [31:0] funct7            // function 7 field
);
    // Decode the instruction fields
    always @(*) begin
        funct7  = instr[31:25];
        rs2     = instr[24:20];
        rs1     = instr[19:15];
        funct3  = instr[14:12];
        rd      = instr[11:7];
        opcode  = instr[6:0];
    end
    
    // Immediate generation and sign extension (based on instruction format)
    always @(*) begin
        // Note to self: Sign-Extension
        // Because imm is a signed value it must be sign-extended to 32 bits. 
        // Sign extension simply means copying the sign bit into the most significant bits.
        casex (opcode)
            // I-Type
            7'b00x0011: imm = { {20{instr[31]}}, instr[31:20] }; // (base & load)
            7'b1100111: imm = { {20{instr[31]}}, instr[31:20] }; // (jalr)
            // S-Type
            7'b0100011: imm = { {20{instr[31]}}, instr[31:25], instr[11:7] }; // (store)
            // B-Type
            7'b1100011: imm = { {19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:6], 1'b0 }; // (branch)
            // J-Type
            7'b1101111: imm = { {11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0 }; // (jump)
            default: imm = 32'b0;
        endcase
    end
endmodule
