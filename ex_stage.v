`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2024 10:03:24 PM
// Design Name: 
// Module Name: ex_stage
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


module ex_stage(
    input wire [31:0] rs1_data,     // data from rs1
    input wire [31:0] rs2_data,     // data from rs2
    input wire [31:0] imm,          // immendiate value from id_stage
    input wire [31:0] pc,           // current pc value
    input wire [6:0] opcode,        // opcode from id_stage
    input wire [2:0] funct3,        // from id_stage
    input wire [6:0] funct7,        // from id_stage
    output wire [31:0] alu_result,  // result from ALU
    output wire [31:0] branch_tgt,  // target address for branch
    output wire branch_taken        // branch decision (taken or not)
);
    // ALU control signals
    wire [3:0] alu_control;
    
    // Branch decision
    reg branch;
    
    always @(*) begin
        case (opcode)
            7'b1100011: begin // B-Type instruction
                case (funct3)
                    3'b000: branch = (rs1_data == rs2_data);                    // BEQ
                    3'b001: branch = (rs1_data != rs2_data);                    // BNE
                    3'b100: branch = ($signed(rs1_data) < $signed(rs2_data));   // BLT
                    3'b101: branch = ($signed(rs1_data) >= $signed(rs2_data));  // BGE
                    3'b110: branch = (rs1_data < rs2_data);                     // BLTU
                    3'b111: branch = (rs1_data >= rs2_data);                    // BGEU
                    default: branch = 1'b0;
                endcase
            end
           default: branch = 1'b0;
        endcase
    end
endmodule
