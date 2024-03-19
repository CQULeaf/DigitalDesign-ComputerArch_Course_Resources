`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/19 16:47:17
// Design Name: 
// Module Name: ALU_sim
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


module ALU_sim;

reg [7:0] num1_tb;
reg [31:0] num2_tb;
reg [2:0] op_tb;
wire [31:0] ans_tb;

ALU myALU (
    .num1(num1_tb),
    .num2(num2_tb),
    .op(op_tb),
    .ans(ans_tb)
);

initial begin
    num1_tb = 0;
    num2_tb = 32'h01;
    op_tb = 0;
    
    // A + B (Unsigned)
    op_tb = 3'b000; num1_tb = 8'b00000010; #10;
    // A - B
    op_tb = 3'b001; num1_tb = 8'b11111111; #10;
    // A AND B
    op_tb = 3'b010; num1_tb = 8'b11111110; #10;
    // A OR B
    op_tb = 3'b011; num1_tb = 8'b10101010; #10;
    // NOT A
    op_tb = 3'b100; num1_tb = 8'b11110000; #10;
    // SLT
    op_tb = 3'b101; num1_tb = 8'b10000001; #10;
end

always @(ans_tb) begin
    $display("Time: %t, Operation: %b, num1: %b, num2: %b, Result: %h", $time, op_tb, num1_tb, num2_tb, ans_tb);
end

endmodule
