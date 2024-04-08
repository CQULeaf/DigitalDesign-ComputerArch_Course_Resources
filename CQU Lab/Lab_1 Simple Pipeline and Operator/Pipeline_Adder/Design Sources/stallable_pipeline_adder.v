`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/02 17:05:13
// Design Name: 
// Module Name: stallable_pipeline_adder
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


module stallable_pipeline_adder(
    input [31:0] cin_a, cin_b,
    input rst, clk, stop, c_in,
    output reg c_out,
    output reg [31:0] sum
);

reg cout1, cout2, cout3, cout4;

reg [7:0] sum1;
reg [15:0] sum2;
reg [23:0] sum3;
reg [31:0] sum4;

reg [23:0] surA1, surB1;
reg [15:0] surA2, surB2;
reg [7:0] surA3, surB3;

// Stage 1
always @(posedge clk) begin
    if (rst)
    begin
        cout1 <= 0;
        sum1 <= 0;
        surA1 <= 0;
        surB1 <= 0;
    end
    else if (stop)
    begin
        cout1 <= cout1;
        sum1 <= sum1;
        surA1 <= surA1;
        surB1 <= surB1;
    end
    else
    begin
        {cout1, sum1} = cin_a[7:0] + cin_b[7:0] + c_in;
        surA1 <= cin_a[31:8];
        surB1 <= cin_b[31:8];
    end
end

// Stage 2
always @(posedge clk) begin
    if (rst) 
    begin
        cout2 <= 0;
        sum2 <= 0;
        surA2 <= 0;
        surB2 <= 0;
    end
    else if (stop)
    begin
        cout2 <= cout2;
        sum2 <= sum2;
        surA2 <= surA2;
        surB2 <= surB2;
    end
    else
    begin
        {cout2, sum2[15:7]} = surA1[7:0] + surB1[7:0] + cout1;
        sum2[7:0] <= sum1; 
        surA2 <= surA1[23:8];
        surB2 <= surB1[23:8];
    end
end 

// Stage 3
always @(posedge clk) begin
    if (rst) 
    begin
        cout3 <= 0;
        sum3 <= 0;
        surA3 <= 0;
        surB3 <= 0;
    end
    else if (stop)
    begin
        c_out <= c_out;
        sum3 <= sum3;
        surA3 <= surA3;
        surB3 <= surB3;
    end
    else
    begin
        {cout3, sum3[23:16]} = surA2[7:0] + surB2[7:0] + cout2;
        sum3[15:0] <= sum2;
        surA3 <= surA2[15:8];
        surB3 <= surB2[15:8];
    end
end

// Stage 4
always @(posedge clk) begin
    if (rst) 
    begin
        cout4 <= 0;
        sum4 <= 0;
    end
    else if (stop)
    begin
        cout4 <= cout4;
        sum4 <= sum4;
    end
    else
    begin
        {cout4, sum4[31:24]} = surA3[7:0] + surB3[7:0] + cout3;
        sum4[23:0] <= sum3;
    end
end

// Assign the output
always @(*) begin
    sum = sum4;
    c_out = cout4;
end

endmodule