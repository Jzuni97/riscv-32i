`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2024 12:15:01 AM
// Design Name: 
// Module Name: i_fetch
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


module if_stage(
    input wire clk,
    input wire rst,
    input wire pc_src,          // PC control signal: 0 -> PC + 4, 1 -> branch/jump
    input wire [31:0] next_pc,  // Next PC value from the branch or jump logic
    output reg [31:0] pc,       // current pc
    output reg [31:0] instr     // Instruction fetched from mem
);
    // Instruction memory
    reg [31:0] instr_mem[0:1023]; // 1024 instructions of 32-bit each

    // PC logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 32'b0;
        else if (pc_src)
            pc <= next_pc;
        else
            pc <= pc + 4;          
    end
    
    // Fetch
    always @(*) begin
        // Note to self: Why [11:2] and not [9:0]?
        // Each instruction is 32 bits (4 bytes), the PC increments by 4 for each instruction. 
        // Therefore, the lower 2 bits of the PC will always be '00'. Stops at 11 beacuse of mem capacity: 2^10 = 1024 (coded mem size).
        instr = instr_mem[pc[11:2]];
    end
    
endmodule
