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
    input reset, clk,
    output reg reginst_ce,
    output reg [31:0] pc
);
    reg [31:0] count;
    initial count = 0;

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            reginst_ce <= 0;
        end else begin
            count <= count + 4;
            reginst_ce <= 1;
            pc <= count;
        end
    end
endmodule
