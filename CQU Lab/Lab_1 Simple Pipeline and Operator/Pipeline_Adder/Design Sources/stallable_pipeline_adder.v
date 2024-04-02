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
    input [7:0] cin_a, cin_b,
    input rst, clk, stop, c_in,
    output reg c_out,
    output reg [7:0] sum
);

reg cout1, cout2, cout3, cout4;

reg [1:0] sum1;
reg [3:0] sum2;
reg [5:0] sum3;
reg [7:0] sum4;

reg [5:0] surA1, surB1;
reg [3:0] surA2, surB2;
reg [1:0] surA3, surB3;

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
        {cout1, sum1} = cin_a[1:0] + cin_b[1:0] + c_in;
        surA1 <= cin_a[7:2];
        surB1 <= cin_b[7:2];
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
        {cout2, sum2[3:2]} = surA1[1:0] + surB1[1:0] + cout1;
        sum2[1:0] <= sum1; 
        surA2 <= surA1[5:2];
        surB2 <= surB1[5:2];
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
        {cout3, sum3[5:4]} = surA2[1:0] + surB2[1:0] + cout2;
        sum3[3:0] <= sum2;
        surA3 <= surA2[3:2];
        surB3 <= surB2[3:2];
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
        {cout4, sum4[7:6]} = surA3[1:0] + surB3[1:0] + cout3;
        sum4[5:0] <= sum3;
    end
end

// Assign the output
always @(*) begin
    sum = sum4;
    c_out = cout4;
end

endmodule
