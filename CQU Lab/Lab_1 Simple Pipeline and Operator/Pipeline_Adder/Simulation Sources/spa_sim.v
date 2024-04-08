`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/02 17:57:03
// Design Name: 
// Module Name: spa_sim
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


module spa_sim( );
    reg [31:0] cin_a, cin_b;
    reg rst, clk, stop, c_in;
    wire c_out;
    wire [31:0] sum;

    initial begin
        clk = 1;
        rst = 0;
        stop = 0;
        cin_a = 32'h0000_0000;
        cin_b = 32'h0000_0000;
        c_in = 0;

        @(posedge clk) cin_a = 32'h0000_0000;cin_b=32'h0000_0000;c_in=1'b0;
        @(posedge clk) cin_a = 32'h0000_0000;cin_b=32'h0000_0000;c_in=1'b0;
        @(posedge clk) cin_a = 32'h0000_0001;cin_b=32'h0000_0001;c_in=1'b0;
        @(posedge clk) cin_a = 32'h0000_0010;cin_b=32'h0000_0001;c_in=1'b0;
        @(posedge clk) cin_a = 32'h0000_0100;cin_b=32'h0000_0001;c_in=1'b0;
        @(posedge clk) cin_a = 32'h0000_1000;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) cin_a = 32'h0001_0000;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) cin_a = 32'h0010_0000;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) stop=1;cin_a = 32'h0100_0000;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) cin_a = 32'h1000_0001;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) stop=0;cin_a = 32'h1000_1111;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) cin_a = 32'h1000_0001;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) cin_a = 32'h1000_0001;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) cin_a = 32'h1000_0001;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) rst=1;cin_a = 32'h1000_0001;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) cin_a = 32'h1000_0011;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) cin_a = 32'h1000_1011;cin_b=32'h0000_0001;c_in=1'b1;
        @(posedge clk) cin_a = 32'h1000_0111;cin_b=32'h0000_0001;c_in=1'b1;
        repeat(10) @(posedge clk);
        $finish;       
    end

    always #5 clk = ~clk;

    stallable_pipeline_adder spa(
        .cin_a(cin_a), .cin_b(cin_b),
        .rst(rst), .clk(clk), .stop(stop), .c_in(c_in),
        .c_out(c_out), .sum(sum)
    );

endmodule