`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2024 12:08:56 AM
// Design Name: 
// Module Name: datapath
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


module datapath(
    input wire clk,
    input wire reset,
    
    // extenal instruction and data memory interfaces
    input wire [31:0] mem_instr,        // instruction fetched from external memory (IFetch)
    input wire [31:0] mem_read_data,    // data read from external data-memory (IMem)
    output wire [31:0] mem_instr_addr,  // address for instruction memory (PC IFetch)
    output wire [31:0] mem_data_addr,   // address for data memory (ALU Result IMem)
    output wire [31:0] mem_write_data,  // data to be written to memory (IMem)
    output wire mem_data_read,          // control signal for reading from memory  MIGHT NEED TO BE REMOVED
    output wire mem_data_write,         // control signal for writing to memory    MIGHT NEED TO BE REMOVED
    
    // controller input (pipelined)
    input wire [1:0] result_src,        // the data that will be written to the register file (alu_result, mem_read, pc+4) (IWriteBack)
    input wire [3:0] alu_control,       // (IExecute)
    input wire [1:0] imm_src,           // (IDecode)
    input wire alu_src,                 // (IExecute)
    input wire pc_src,                  // (IExecute)
    input wire pc_jal_src,              // (IExecute)
    input wire reg_write,               // register file write flag (IWriteBack)
    input wire mem_write,               // data memory write flag (IMem)
    output wire [31:0] instrD,          // instruction at decode stage
    
    // outputs for control
    output wire [31:0] pc,              // (IFetch)
    output wire zero,                   // (IExecute)
    
    // outputs for hazard
    // !!!!!!!!! TODO
    output wire [31:0] rs1D, rs2D, rs1E, rs2E,
    output wire [31:0] rdD, rdE, rdM, rdW
);
    // internal signals
    wire [31:0] pcD, pcE;
    wire [31:0] pc_nextF, pc_plus4F, pc_plus4D, pc_plus4E, pc_plus4M, pc_plus4W, pc_targetE, branch_jump_targetF;
    wire [31:0] rd1D, rd2D, rd1E, rd2E;
    wire [31:0] imm_extD, imm_extE;
    wire [31:0] alu_resultE;
    wire [31:0] resultW;
    
    //  --- Instruction Fetch Stage (IF) ---
    mux2 jmux(pc_targetE, alu_resultE, pc_jal_src, branch_jump_targetF);
    mux2 pcmux(pc_plus4F, branch_jump_targetF, pc_src, pc_nextF);
    flopr pcflop(clk, reset, pc_nextF, pc);
    adder pcadd4(pc, 32'd4, pc_plus4F);
    
    //  --- Instruction Fetch-Decode Pipeline Register (IF->ID) ---
    if_id pipereg0(
        clk,
        reset,
        mem_instr,
        pc,
        pc_plus4F,
        instrD,
        pcD,
        pc_plus4D
    );
    
    //  --- Instruction Decode Stage (ID) ---
    assign rs1D = instrD[19:15];
    assign rs2D = instrD[24:20];
    assign rdD = instrD[11:7];
    regfile rf(clk, reg_write, resultW, rs1D, rs2D, rdW, rd1D, rd2D);
    imm_extend ext(instrD, imm_src, imm_extD);
    
    //  --- Instruction Decode-Execute Pipeline Register (ID->IEx) ---
    
    //  --- Instruction Execute Stage (IEx) ---
    
endmodule
