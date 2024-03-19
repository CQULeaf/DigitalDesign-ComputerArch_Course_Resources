`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/19 19:24:24
// Design Name: 
// Module Name: ALU_top
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


module ALU_top(
    input [15:13] sw,
    input [7:0] ins,
    input clk,
    input reset,
    output [6:0] seg,
    output [7:0] ans
    );
    
wire [31:0] num2 = 32'h01;
wire [31:0] num1 = {24'b0, ins[7:0]};
wire [2:0] op = sw[15:13];
wire [31:0] alu_result;

ALU alu(
    .num1(num1),
    .num2(num2),
    .op(op),
    .ans(alu_result)
);

display display_inst(
    .clk(clk),
    .reset(reset),
    .s(alu_result),
    .seg(seg),
    .ans(ans)
);
endmodule
