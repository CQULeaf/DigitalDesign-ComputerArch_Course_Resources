`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/12 17:51:57
// Design Name: 
// Module Name: datapath
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


module datapath(
input clk, rst,
// FETCH
output [31:0] pcF,
input [31:0] instrD,

// DECODE
input regwriteD, memtoregD, branchD, memwriteD, jumpD, regdstD, alusrcD, pcsrcD,
input [2:0] alucontrolD,
output equalD,
output wire [5:0] op, funct,
output stallD,

// EXECUTE
// no i/o signal

// MEMORY
input [31:0] readdataM,
output [31:0] writedataM, aluoutM,
output wire memwriteM

// WRITEBACK
// no i/o signal
);

    // FETCH
    wire [31:0] nextpc, pcplus4F, pcbranchD, pcjumpD, pctemp;
    wire stallF;

    // DECODE
    wire [31:0] pcplus4D;
    wire [31:0] rd1D, rd2D; // 读取寄存器的数据
    wire [31:0] branchnum1D, branchnum2D; // 分支的数据，判断是否相等
    wire [4:0] rsD, rtD, rdD; // 操作数
    wire [31:0] sign_extendD; // 符号扩展
    wire forwardAD, forwardBD; // 数据前递

    // Execute
    wire regwriteE, memtoregE, memwriteE, regdstE, alusrcE; // 操作码
    wire [2:0] alucontrolE; // ALU控制信号
    wire [31:0] srcAE, srcBE, aluoutE; // ALU的输入
    wire [4:0] rsE, rtE, rdE; // 操作数
    wire [31:0] sign_extendE; // 符号扩展
    wire [31:0] rd1E, rd2E; // 读取寄存器的数据
    wire [4:0] writeregE; // 写寄存器的地址
    wire [31:0] writedataE; // 写寄存器的数据
    wire [1:0] forwardAE, forwardBE; // 数据前递
    wire flushE; // 清空流水线

    // MEMORY
    wire regwriteM, memtoregM;
    wire [4:0] writeregM;

    // WRITEBACK
    wire regwriteW, memtoregW;
    wire [4:0] writeregW;
    wire [31:0] readdataW, aluoutW, resultW;

    // pc
    assign pcjumpD = {pcplus4F[31:28], instrD[25:0], 2'b00};
    pc pc_inst1(.clk(clk), .rst(rst), .en(~stallF), .newPC(nextpc), .pc(pcF));
    mux2 sel_PCtemp(.option1(pcplus4F), .option2(pcbranchD), .select(pcsrcD), .data(pctemp));
    mux2 sel_PCnext(.option1(pctemp), .option2(pcjumpD), .select(jumpD), .data(nextpc), .rst(rst));
    adder addPC(.a(pcF), .b(32'd4), .y(pcplus4F));

    // FETCH ----> DECODE
    flopenrc #32 pcplus4FD_inst(.clk(clk), .rst(rst), .en(~stallD), .clear(pcsrcD), .d(pcplus4F), .q(pcplus4D));
    assign op = instrD[31:26];
    assign funct = instrD[5:0];
    regfile rf_inst1(.clk(clk), .we3(regwriteW), .ra1(instrD[25:21]), .ra2(instrD[20:16]), .wa3(writeregW), .wd3(resultW), .rd1(rd1D), .rd2(rd2D));
    assign rsD = instrD[25:21];
    assign rtD = instrD[20:16];
    assign rdD = instrD[15:11];
    sign_extend extend(.sign(instrD[15:0]), .sign_extend(sign_extendD)); 
    adder addbranchD(.a({sign_extendD[29:0], 2'b00}), .b(pcplus4D), .y(pcbranchD));
    mux2 sel_brnum1(.option1(rd1D), .option2(aluoutM), .select(forwardAD), .data(branchnum1D));
    mux2 sel_brnum2(.option1(rd2D), .option2(aluoutM), .select(forwardBD), .data(branchnum2D));
    assign equalD = branchnum1D == branchnum2D ? 1'b1 : 1'b0;

    // DECODE ----> EXECUTE
    floprc #1 regwriteDE(.clk(clk), .rst(rst), .clear(flushE), .d(regwriteD), .q(regwriteE));
    floprc #1 memtoregDE(.clk(clk), .rst(rst), .clear(flushE), .d(memtoregD), .q(memtoregE));
    floprc #1 memwriteDE(.clk(clk), .rst(rst), .clear(flushE), .d(memwriteD), .q(memwriteE));
    floprc #1 regdstDE(.clk(clk), .rst(rst), .clear(flushE), .d(regdstD), .q(regdstE));
    floprc #1 alusrcDE(.clk(clk), .rst(rst), .clear(flushE), .d(alusrcD), .q(alusrcE));
    floprc #3 alucontrolDE(.clk(clk), .rst(rst), .clear(flushE), .d(alucontrolD), .q(alucontrolE));
    floprc #5 rsDE(.clk(clk), .rst(rst), .clear(flushE), .d(rsD), .q(rsE));
    floprc #5 rtDE(.clk(clk), .rst(rst), .clear(flushE), .d(rtD), .q(rtE));
    floprc #5 rdDE(.clk(clk), .rst(rst), .clear(flushE), .d(rdD), .q(rdE));
    floprc #32 sign_extendDE(.clk(clk), .rst(rst), .clear(flushE), .d(sign_extendD), .q(sign_extendE));
    floprc #32 rd1DE(.clk(clk), .rst(rst), .clear(flushE), .d(rd1D), .q(rd1E));
    floprc #32 rd2DE(.clk(clk), .rst(rst), .clear(flushE), .d(rd2D), .q(rd2E));
    mux3 srcAE_inst(.option1(rd1E), .option2(resultW), .option3(aluoutM), .select(forwardAE), .data(srcAE));
    mux3 srcBE_temp_inst(.option1(rd2E), .option2(resultW), .option3(aluoutM), .select(forwardBE), .data(writedataE));
    mux2 srcDE_inst(.option1(writedataE), .option2(sign_extendE), .select(alusrcE), .data(srcBE)); 
    mux2 #5 writeregE_sel(.option1(rtE), .option2(rdE), .select(regdstE), .data(writeregE));
    ALU mainalu(.num1(srcAE), .num2(srcBE), .op(alucontrolE), .ans(aluoutE));

    // EXECUTE ----> MEMORY
    flopr #1 regwriteEM(.clk(clk), .rst(rst), .d(regwriteE), .q(regwriteM));
    flopr #1 memtoregEM(.clk(clk), .rst(rst), .d(memtoregE), .q(memtoregM));
    flopr #1 memwriteEM(.clk(clk), .rst(rst), .d(memwriteE), .q(memwriteM));
    flopr #5 writeregEM(.clk(clk), .rst(rst), .d(writeregE), .q(writeregM));
    flopr #32 aluoutEM(.clk(clk), .rst(rst), .d(aluoutE), .q(aluoutM));
    flopr #32 writedataEM(.clk(clk), .rst(rst), .d(writedataE), .q(writedataM));

    // MEMORY ----> WRITEBACK
    flopr #1 regwriteMW(.clk(clk), .rst(rst), .d(regwriteM), .q(regwriteW));
    flopr #1 memtoregMW(.clk(clk), .rst(rst), .d(memtoregM), .q(memtoregW));
    flopr #5 writeregMW(.clk(clk), .rst(rst), .d(writeregM), .q(writeregW));
    flopr #32 readdataMW(.clk(clk), .rst(rst), .d(readdataM), .q(readdataW));
    flopr #32 aluoutMW(.clk(clk), .rst(rst), .d(aluoutM), .q(aluoutW));
    mux2 resultW_inst(.option1(aluoutW), .option2(readdataW), .select(memtoregW), .data(resultW));

    // Hazard Control
    hazard hazard_control(.stallF(stallF), .stallD(stallD), .branchD(branchD),
    .forwardAD(forwardAD), .forwardBD(forwardBD), .rsD(rsD), .rtD(rtD), .flushE(flushE), .rsE(rsE), .rtE(rtE), 
    .forwardAE(forwardAE), .forwardBE(forwardBE), .memtoregE(memtoregE), .regwriteE(regwriteE), .writeregE(writeregE), 
    .writeregW(writeregW), .regwriteW(regwriteW), .memtoregM(memtoregM), .regwriteM(regwriteM), .writeregM(writeregM));
endmodule