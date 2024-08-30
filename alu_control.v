`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2024 02:18:56 PM
// Design Name: 
// Module Name: alu_control
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


module alu_control(
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg [3:0] alu_operation
);
    always @(*) begin
        case (opcode)
            // R-Type instructions
            7'b0110011: begin
                case ({ funct7[5], funct3 }) // only important bit of funct7 is bit 6
                    4'b0_000: alu_operation = 4'b0000;  // ADD
                    4'b1_000: alu_operation = 4'b0001;  // SUB
                    4'b0_111: alu_operation = 4'b0010;  // AND
                    4'b0_110: alu_operation = 4'b0011;  // OR
                    4'b0_100: alu_operation = 4'b0100;  // XOR
                    4'b0_001: alu_operation = 4'b0101;  // SLL
                    4'b0_101: alu_operation = 4'b0110;  // SRL
                    4'b1_101: alu_operation = 4'b0111;  // SRA
                    4'b0_010: alu_operation = 4'b1000;  // SLT
                    4'b0_011: alu_operation = 4'b1001;  // SLTU
                    default: alu_operation = 4'bxxxx;   // undefined
                endcase
            end
            // I-Type instructions
            7'b0010011: begin
                case (funct3)
                    3'b000: alu_operation = 4'b0000;    // ADDI
                    3'b111: alu_operation = 4'b0001;    // ANDI
                    3'b110: alu_operation = 4'b0011;    // ORI
                    3'b100: alu_operation = 4'b0100;    // XORI
                    3'b001: alu_operation = 4'b0101;    // SLLI
                    3'b010: alu_operation = 4'b1000;    // SLTI
                    3'b011: alu_operation = 4'b1001;    // SLTIU
                    3'b101: begin
                        if (funct7[5]) alu_operation = 4'b0111; // SRAI
                        else alu_operation = 4'b0110;           // SRLI
                    end
                endcase
            end
            7'b0000011: alu_operation = 4'b0000; // LW
            7'b0100011: alu_operation = 4'b0000; // SW
            // B-Type instruction
            7'b1100011: begin
                case (funct3)
                    // *Note to self:
                    // TODO: Learn what/why operations ALU uses for branch
                    3'b000: alu_operation = 4'b0001;    // BEQ (uses subtraction)
                    3'b001: alu_operation = 4'b0001;    // BNE (uses subtraction)
                    3'b100: alu_operation = 4'b1000;    // BLT (uses SLT)
                    3'b101: alu_operation = 4'b1000;    // BGE (uses SLT)
                    3'b110: alu_operation = 4'b1001;    // BLTU (uses SLTU)
                    3'b111: alu_operation = 4'b1001;    // BGEU (uses SLTU)
                    default: alu_operation = 4'bxxxx;   // undefined
                endcase
            end
            7'b1101111: alu_operation = 4'b0000; // JAL (use as ADD)
            7'b1100111: alu_operation = 4'b0000; // JALR (use as ADD)
            7'b0110111: alu_operation = 4'b0000; // LUI (use as ADD)
            7'b0010111: alu_operation = 4'b0000; // AUIPC (use as ADD)
            default: alu_operation = 4'bxxxx; // Undefined
        endcase
    end
endmodule
