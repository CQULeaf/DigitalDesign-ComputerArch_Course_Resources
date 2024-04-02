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
    reg [7:0] cin_a, cin_b;
    reg rst, clk, stop, c_in;
    wire c_out;
    wire [7:0] sum;

    initial begin
        clk = 1;
        rst = 0;
        stop = 0;
        c_in = 0;
        cin_a = 8'h00;
        cin_b = 8'h00;

        @(posedge clk) cin_a = 8'h00; cin_b = 8'h01; c_in = 0;
        @(posedge clk) cin_a = 8'h01; cin_b = 8'h01; c_in = 0;
        @(posedge clk) cin_a = 8'h02; cin_b = 8'h01; c_in = 0;
        @(posedge clk) cin_a = 8'h03; cin_b = 8'h01; c_in = 0;
        @(posedge clk) cin_a = 8'h04; cin_b = 8'h01; c_in = 0;
        @(posedge clk) cin_a = 8'h08; cin_b = 8'h01; c_in = 1;
        @(posedge clk) cin_a = 8'h10; cin_b = 8'h01; c_in = 1;
        @(posedge clk) cin_a = 8'h20; cin_b = 8'h01; c_in = 1;
        @(posedge clk) stop = 1; cin_a = 8'h40; cin_b = 8'h01; c_in = 1;
        @(posedge clk) cin_a = 8'h80; cin_b = 8'h01; c_in = 1;
        @(posedge clk) stop = 0; cin_a = 8'h81; cin_b = 8'h01; c_in = 0;
        @(posedge clk) cin_a = 8'h82; cin_b = 8'h01; c_in = 0;
        @(posedge clk) cin_a = 8'h83; cin_b = 8'h01; c_in = 0;
        @(posedge clk) cin_a = 8'h84; cin_b = 8'h01; c_in = 0;
        @(posedge clk) rst = 1; cin_a = 8'h88; cin_b = 8'h01; c_in = 1;
        @(posedge clk) rst = 0; cin_a = 8'h90; cin_b = 8'h01; c_in = 1;
        @(posedge clk) cin_a = 8'hA0; cin_b = 8'h01; c_in = 1;
        @(posedge clk) cin_a = 8'hB0; cin_b = 8'h01; c_in = 1;
        @(posedge clk) cin_a = 8'hC0; cin_b = 8'h01; c_in = 1;
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