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



module controller_main(
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    output reg [1:0] result_src,
    output reg [1:0] imm_src,
    output reg [1:0] alu_op,
    output reg alu_src,
    output reg reg_write,
    output reg mem_write,
    output reg branch,
    output reg jump
);

    always @(*) begin
        // set default values
        result_src = 2'b00;
        imm_src = 2'b00;
        alu_op = 2'b00;
        alu_src = 0;
        reg_write = 0;
        mem_write = 0;
        branch = 0;
        jump = 0;
        
        case (opcode)
            // B-Type 
            7'b1100011: begin
                reg_write = 0;
                alu_src = 0;
                mem_write = 0;
                branch = 1;
                jump = 0;
                imm_src = 2'b10;    // b-type
                alu_op = 2'b01;     // branch
            end
            // R-Type
            7'b0110011: begin
                reg_write = 1;
                alu_src = 0;
                mem_write = 0;
                result_src = 2'b00; // from alu
                imm_src = 2'b00;    // i-type
                alu_op = 2'b10;     // funct-based
            end
            // I-Type ALU
            7'b0010011: begin
                reg_write = 1;
                alu_src = 1;
                mem_write = 0;
                result_src = 2'b00; // from alu
                imm_src = 2'b00;    // i-type
                alu_op = 2'b10;     // funct-based
            end
            // LW
            7'b0000011: begin
                reg_write = 1;
                alu_src = 1;
                mem_write = 0;
                imm_src = 2'b00;    // i-type
                result_src = 2'b01; // from mem
                alu_op = 2'b00;     // add
            end
            // SW
            7'b0100011: begin
                reg_write = 0;
                alu_src = 1;
                mem_write = 0;
                imm_src = 2'b01;    // s-type
                alu_op = 2'b00;     // add
            end
            // JAL
            7'b1101111: begin
                reg_write = 1;
                jump = 1;
                imm_src = 2'b11;    // j-type
                result_src = 2'b10; // pc+4
            end
            // JALR
            7'b1100111: begin
                reg_write = 1;
                jump = 1;
                imm_src = 2'b00;    // i-type
                result_src = 2'b10; // pc+4
            end
        endcase
    end
endmodule
