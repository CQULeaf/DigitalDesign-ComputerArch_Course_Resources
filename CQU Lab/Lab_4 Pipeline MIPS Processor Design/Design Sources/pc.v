`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/30 21:25:15
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
    output reg [31:0] pc,
    output reg inst_ce
);

    always @(posedge clk) begin
        if (rst) begin
            pc <= 32'h0;
            inst_ce <= 1'b0;
        end else begin
            pc <= newPC;
            inst_ce <= 1'b1;
        end
    end

endmodule
