`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/18 23:21:58
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [7:0] num1,
    input [31:0] num2,
    input [2:0] op,
    output reg [31:0] ans
    );

always  @ (*) 
begin
    case(op)
        3'b000: ans = {24'b0, num1} + num2;
        3'b001: ans = {24'b0, num1} - num2;
        3'b010: ans = {24'b0, num1} & num2;
        3'b011: ans = {24'b0, num1} | num2;
        3'b100: ans = ~{24'b0, num1};
        3'b101: ans = ({24'b0, num1} < num2) ? 32'b1 : 32'b0;
        3'b110: ans = 32'b0;
        3'b111: ans = 32'b0;
        default : ans = 32'hX;
    endcase
end

endmodule
