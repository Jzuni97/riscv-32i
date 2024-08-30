`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/22/2024 12:26:50 AM
// Design Name: 
// Module Name: alu
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


module alu(
    input       [31:0]  op1, op2,
    input       [3:0]   alu_op, // TODO Not sure the size. But its an array
    output reg  [31:0]  result,
    // Flags: Zero, Negative, Carry, Overflow
    output reg Z, N, C, V
);
    // 33-bit temp for overflow/underflow
    reg [32:0] temp;
    
    always @(*) begin
        case (alu_op)
            4'b0000: temp = { 1'b0, op1 } + { 1'b0, op2 };                      // ADD
            4'b0001: temp = { 1'b0, op1 } - { 1'b0, op2 };                      // SUB
            4'b0010: result = op1 & op2;                                        // AND
            4'b0011: result = op1 | op2;                                        // OR
            4'b0100: result = op1 ^ op2;                                        // XOR
            4'b0101: result = op1 << op2[4:0];                                  // SLL
            4'b0110: result = op1 >> op2[4:0];                                  // SRL
            4'b0111: result = $signed(op1) >>> op2[4:0];                        // SRA
            4'b1000: result = ($signed(op1) < $signed(op2)) ? 32'b1 : 32'b0;    // SLT  *Note: SLT typically treats inputs as signed. For unsigned use SLTU.
            4'b1001: result = (op1 < op2) ? 32'b1 : 32'b0;                      // SLTU
            default: result = 32'b0;
       endcase
       
       // Compute flags
        Z = (result == 32'b0);
        N = result[31];
        if (alu_op == 4'b0000 || alu_op == 4'b0001) begin
            result = temp[31:0]; // dont forget about result 😁
            C = temp[32];
            V = (op1[31] == op2[31]) && (result[31] != op1[31]);
        end else begin
            C = 0;
            V = 0;
        end
    end
endmodule
