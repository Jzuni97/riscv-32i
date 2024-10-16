`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2024 08:25:19 PM
// Design Name: 
// Module Name: controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// TODO:
//  Add pipeline!!
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module controller(
    input wire [31:0] instruction,
    input wire zero,                // zero flag from alu at IExecute stage
    output wire [1:0] result_src,   // the data that will be written to the register file (alu_result, mem_read, pc+4)
    output wire [3:0] alu_control,
    output wire [1:0] imm_src,
    output wire alu_src,            // alu source
    output wire pc_src,             // pc source
    output wire pc_jal_src,         // jump source (jal vs jalr)
    output wire reg_write,          // register file write flag
    output wire mem_write,
    output wire branch,
    output wire jump
);
    // Extract relevant fields from instruction
    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];
    wire [6:0] funct7 = instruction[31:25];
    
    // Internal ALU control signal for ALU controller
    wire [1:0] alu_op;
    
    // main decoder
    controller_main cm(
        .opcode(opcode),
        .funct3(funct3),
        .result_src(result_src),
        .imm_src(imm_src),
        .alu_src(alu_src),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump),
        .alu_op(alu_op)             // internal operation signal for alu controller
    );
    
    // alu decoder
    controller_alu calu(
        .alup_op(alu_op),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_control)
    );
    
    // !!!!!!!!!!! TODO Implement pipelines and incorporate here
    
    // signals outside controllers
    assign pc_src = jump | (branch & zero);
    assign pc_jal_src = (opcode == 7'b1100111) ? 1 : 0; // jalr
endmodule
