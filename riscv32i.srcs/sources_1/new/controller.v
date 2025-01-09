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
    input wire clk, reset,

    input wire [31:0] instruction,
    input wire zeroE,                           // zero flag from alu at IExecute stage
    
    output wire [1:0] result_srcW,              // the data that will be written to the register file (alu_result, mem_read, pc+4)
    output wire [3:0] alu_controlE,
    output wire [1:0] imm_srcD,
    output wire alu_srcE,                       // alu source
    output wire pc_srcE,                        // pc source
    output wire pc_jal_srcE,                    // jump source (jal vs jalr)
    output wire reg_writeM, reg_writeW,         // register file write flag
    output wire mem_writeM
);
    // Extract relevant fields from instruction
    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];
    wire [6:0] funct7 = instruction[31:25];
    
    // Internal ALU control signal for ALU controller
    wire [1:0] alu_opD;
    
    // Pipelined registers
    wire [1:0] result_srcD, result_srcE, result_srcM;
    wire [3:0] alu_controlD;
    wire alu_srcD;
    wire reg_writeD, reg_writeE;
    wire mem_writeD, mem_writeE;
    wire branchD, branchE, jumpD, jumpE;
    
    // main decoder
    controller_main cm(
        .opcode(opcode),
        .funct3(funct3),
        .result_src(result_srcD),
        .imm_src(imm_srcD),
        .alu_src(alu_srcD),
        .reg_write(reg_writeD),
        .mem_write(mem_writeD),
        .branch(branchD),
        .jump(jumpD),
        .alu_op(alu_opD)             // internal operation signal for alu controller
    );
    
    // alu decoder
    controller_alu calu(
        .alup_op(alu_opD),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .alu_control(alu_controlD)
    );
    
    // pipelined datapath
    c_id_iex c_pipereg0(
        .clk(clk),
        .reset(reset),
        .result_srcD(result_srcD),
        .alu_controlD(alu_controlD),
        .alu_srcD(alu_srcD),
        .reg_writeD(reg_writeD),
        .mem_writeD(mem_writeD),
        .branchD(branchD),
        .jumpD(jumpD),
        .result_srcE(result_srcE),
        .reg_writeE(reg_writeE),
        .alu_controlE(alu_controlE),
        .alu_srcE(alu_srcE),
        .mem_writeE(mem_writeE),
        .branchE(branchE),
        .jumpE(jumpE)
    );
    
    c_iex_mem c_pipereg1(
        .clk(clk),
        .reset(reset),
        .result_srcE(result_srcE),
        .reg_writeE(reg_writeE),
        .mem_writeE(mem_writeE),
        .result_srcM(result_srcM),
        .reg_writeM(reg_writeM),
        .mem_writeM(mem_writeM)
    );
    
    c_mem_iwb c_pipereg2(
        .clk(clk),
        .reset(reset),
        .result_srcM(result_srcM),
        .reg_writeM(reg_writeM),
        .result_srcW(result_srcW),
        .reg_writeW(reg_writeW)
    );
    
    // signals outside controllers
    assign pc_srcE = jumpE | (branchE & zeroE);
    assign pc_jal_srcE = (opcode == 7'b1100111) ? 1 : 0; // jalr
endmodule
