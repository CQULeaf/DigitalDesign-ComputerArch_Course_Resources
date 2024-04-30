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
    output reg [31:0] pc_next,
    input clk,
    input rst,
    input inst_ce
);

    localparam INCREMENT = 32'h4;
    
    always @(posedge clk) begin
        if (rst) begin
            pc_next <= pc;
        end else if (inst_ce) begin  // 为1
            pc_next <= pc + INCREMENT;
        end else begin
            pc_next <= pc;
        end
    end

    pc pc_update(
        .clk(clk),
        .rst(rst),
        .inst_ce(inst_ce),
        .pc(pc),
        .newPC(pc_next)
    );
endmodule
