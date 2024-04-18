`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/16 23:41:08
// Design Name: 
// Module Name: adder
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


module adder(
    input [31:0] pc,
    input [31:0] a_in,
    output reg [31:0] pc_next,
    input clk,
    input reset,
    input reginst_ce
);
    
    always @(posedge clk) begin
        if (reset) begin
            pc_next <= pc;
        end else if (reginst_ce) begin  // 为1
            pc_next <= pc + a_in;
        end else begin
            pc_next <= pc;
        end
    end

    pc u(
        .clk(clk),
        .reset(reset),
        .reginst_ce(reginst_ce),
        .pc(pc)
    );
endmodule