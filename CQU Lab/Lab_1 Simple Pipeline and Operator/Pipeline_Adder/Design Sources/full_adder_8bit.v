`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/19 17:20:29
// Design Name: 
// Module Name: full_adder_8bit
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


module full_adder_8bit(
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] sum,
    output cout
    );
    
    assign  {cout, sum} = a + b + cin;

endmodule
