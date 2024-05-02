`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/16 20:07:44
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
    input [31:0] num1,
    input [31:0] num2,
    input [2:0] op,
    output reg zero,
    output reg [31:0] ans
    );

always  @ (*) 
begin
    case(op)
        3'b000: ans = num1 & num2;
        3'b001: ans = num1 | num2;
        3'b010: ans = num1 + num2;
        3'b011: ans = 32'b0;
        3'b100: ans = ~num1;
        3'b101: ans = 32'b0;
        3'b110: begin
                    ans = num1 - num2;
                    zero = (ans == 32'b0) ? 1 : 0;
                end
        3'b111: ans = (num1 < num2) ? 32'b1 : 32'b0;
        default : ans = 32'hX;
    endcase
end

endmodule