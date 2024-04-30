`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/26 23:17:05
// Design Name: 
// Module Name: pc
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


module pc(
    input clk, rst,
    input wire [31:0] newPC,
    output reg [31:0] pc
);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc <= 32'h0;
        end else begin
            pc <= newPC;
        end
    end

endmodule
