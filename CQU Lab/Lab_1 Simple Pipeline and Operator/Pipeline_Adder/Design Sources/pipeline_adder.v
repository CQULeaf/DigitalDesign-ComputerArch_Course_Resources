`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/19 17:28:23
// Design Name: 
// Module Name: pipeline_adder
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


module pipeline_adder(
    input clk,
    input rst,
    input [7:0] a,
    input [7:0] b,
    input pause_signal,
    input flush_signal,
    output reg [7:0] sum,
    output reg cout
    );
    
    reg [7:0] stage1_a, stage1_b;
    reg [7:0] stage2_a, stage2_b;
    reg [7:0] stage3_sum;
    reg stage3_cout;
    
    reg pause, flush;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            stage1_a <= 0;
            stage1_b <= 0;
            stage2_a <= 0;
            stage2_b <= 0;
            stage3_sum <= 0;
            stage3_cout <= 0;
            pause <= 0;
            flush <= 0;
        end else begin
            if (flush_signal) begin 
                stage2_a <= 0;
                stage2_b <= 0;
                stage3_sum <= 0;
                stage3_cout <= 0;
                flush <= 1;
            end else if (!pause_signal) begin 
                stage1_a <= a;
                stage1_b <= b;
                stage2_a <= stage_a;
                stage2_b <= stage_b;
                {stage3_cout, stage3_sum} <= stage2_a + stage2_b;
                sum <= stage3_sum;
                cout <= stage3_cout;
                pause <= 0;
            end else {
                
    
endmodule
