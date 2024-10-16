`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2024 09:00:41 PM
// Design Name: 
// Module Name: controller_main
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


module controller_alu(
    input wire [1:0] alu_op,        // alu operation from the main control unit
    input wire [6:0] opcode,        // opcode field from instruction. needed for differentiating R&I types
    input wire [2:0] funct3,        // funct3 field from instruction
    input wire [6:0] funct7,        // funct7 field from instruction
    output reg [3:0] alu_control    // alu control signal to be sent to the ALU
);

    // For debug purposes
    wire funct7b5;
    wire opb5;
    assign funct7b5 = funct7[5];
    assign opb5 = opcode[5];
    
    
    // REVIEW!!!!!!!!!!!!!
    
    always @(*) begin
        case (alu_op)
            // LW, SW, JALR, AUIPC
            2'b00: alu_control = 4'b0000;   // ADD
            // B-Type
            2'b01: begin
                // determine the alu_op based on branch type
                case (funct3)
                    3'b000: alu_control = 4'b0001; // BEQ -> SUB
                    3'b001: alu_control = 4'b0001; // BNE -> SUB
                    3'b100: alu_control = 4'b1000; // BLT -> SLT
                    3'b101: alu_control = 4'b1000; // BGE -> SLT
                    3'b110: alu_control = 4'b1001; // BLTU -> SLTU
                    3'b111: alu_control = 4'b1001; // BGEU -> SLTU
                    default: alu_control = 4'bxxxx;
                endcase
            end
            // R-Type & I-Type arithmentic
            2'b10: begin
                case ({ funct7b5, funct3, opb5 })
                    // ADD
                    5'bx_000_0: alu_control = 4'b0000;  // ADDI (I-Type)
                    5'b0_000_1: alu_control = 4'b0000;  // ADD (R-Type)
                    // SUB
                    5'b1_000_1: alu_control = 4'b0001;  // SUB (R-Type only)
                    // Rest
                    5'b0_111_x: alu_control = 4'b0010;  // AND
                    5'b0_110_x: alu_control = 4'b0011;  // OR
                    5'b0_100_x: alu_control = 4'b0100;  // XOR
                    5'b0_001_x: alu_control = 4'b0101;  // SLL
                    5'b0_101_x: alu_control = 4'b0110;  // SRL
                    5'b1_101_x: alu_control = 4'b0111;  // SRA
                    5'b0_010_x: alu_control = 4'b1000;  // SLT
                    5'b0_011_x: alu_control = 4'b1001;  // SLTU
                    default: alu_control = 4'bxxxx;
                endcase
            end
            // LUI
            2'b11: alu_control = 4'b0000;   // ADD
            default: alu_control = 4'bxxxx; // undefined
        endcase
    end

endmodule
