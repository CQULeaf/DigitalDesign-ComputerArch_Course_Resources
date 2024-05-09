`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/30 20:21:37
// Design Name: 
// Module Name: Lab2_sim
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


module Lab2_sim();
    reg clk, rst;
    wire [2:0] alucontrol;
    wire regwrite, regdst, jump, alusrc, pcsrc, memwrite, memtoreg;
    wire [6:0] seg;
    wire [7:0] ans;

    top top_inst(
        .clk_in(clk),
        .rst(rst),
        .memtoreg(memtoreg),
        .memwrite(memwrite),
        .pcsrc(pcsrc),
        .alusrc(alusrc),
        .regdst(regdst),
        .regwrite(regwrite),
        .jump(jump),
        .alucontrol(alucontrol),
        .seg(seg),
        .ans(ans)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 1;
        rst = 1;
        #5 rst = 0;
    end

endmodule
