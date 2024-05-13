`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/12 17:33:15
// Design Name: 
// Module Name: hazard
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


module hazard(
input [4:0]rsE, rtE, writeregM, writeregW, rsD, rtD,
input regwriteM, regwriteW, memtoregE,
output reg [1:0] forwardAE, forwardBE,
output wire stallF, stallD, flushE,
input [4:0] writeregE,
input branchD, regwriteE, memtoregM,
output wire [1:0] forwardAD, forwardBD
    );

always @(*) begin
    forwardAE = 2'b00;
    forwardBE = 2'b00;
    if (rsE != 0) begin 
        if ((rsE == writeregM) & regwriteM) begin
            forwardAE = 2'b10;
        end //ALU数据前推
        else if ((rsE == writeregW) & regwriteW) begin
            forwardAE = 2'b01;
        end //寄存器
        else begin
            forwardAE = 2'b00;
        end
    end

    if (rtE != 0) begin
        if ((rtE == writeregM) & regwriteM) begin
            forwardBE = 2'b10;
        end
        else if ((rtE == writeregW) & regwriteW) begin
            forwardBE = 2'b01;
        end
        else begin
            forwardBE = 2'b00;
        end
    end
end

// 数据前推
assign forwardAD = (rsD != 0) & (rsD == writeregM) & regwriteM;
assign forwardBD = (rtD != 0) & (rtD == writeregM) & regwriteM;

// 刷新与暂停的实现
wire lwstall;
wire branchstall;
assign branchstall = branchD &
    (regwriteE & (writeregE == rsD | writeregE == rtD) | memtoregM & (writeregM == rsD | writeregM == rtD));
assign lwstall = memtoregE & (rsE == rsD | rtE == rtD);
assign stallF = lwstall | branchstall;
assign stallD = stallF;
assign flushE = stallF;
endmodule