`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/19 17:23:03
// Design Name: 
// Module Name: pipeline_control
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


module pipeline_control(
    input clk,
    input rst,
    input pause_signal,
    input flush_signal,
    output reg pause,
    output reg flush
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pause <= 0;
            flush <= 0;
        end else begin
            pause <= pause_signal;
            flush <= flush_signal;
        end 
     end
endmodule
