`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/30 18:58:14
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clk_in,
    input rst,
    output reg hz
    );

    reg [27:0] count;
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            hz <= 0;
            count <= 0;
        end else begin
            if (count >= 27'd99_999_999) begin
                hz <= ~hz;
                count <= 0;
            end else begin
                count <= count + 1;
            end
        end
        
    end
endmodule
