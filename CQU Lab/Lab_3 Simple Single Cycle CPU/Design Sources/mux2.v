`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/16 20:16:20
// Design Name: 
// Module Name: mux2
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


module mux2(
    input [2:0] in1,  // 第一个输入
    input [2:0] in2,  // 第二个输入
    input SW15,       // 选择信号
    output reg [2:0] out  // 输出
    );
    
always @ (in1, in2, SW15) begin
    case (SW15) // 使用1位宽的选择信号作为case选择表达式
        1'b0: out = in1; // 当SW14是0
        1'b1: out = in2; // 当SW14是1
        default: out = 3'bxxx; // 不匹配的情况
    endcase
end

endmodule