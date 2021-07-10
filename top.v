`timescale 1ns / 1ps
module top (
    input clk,reset,start,
    input Rx_Serial,
    input mem2uart,
    output [3:0] AN,
    output [7:1] cathodes,
    output recv_done,
    output send_done,
    output Tx_Serial);

    parameter MAX_CAP=64;
    parameter MAX_ITEM=16;

    reg [6:0] num;

    reg [31:0] cache [MAX_CAP-1:0];
    reg [31:0] weight [MAX_ITEM-1:0];
    reg [31:0] value [MAX_ITEM-1:0];
    reg [31:0] item_num, cap, cnt;

    wire [31:0] out_value;
    wire [31:0] out_weight;

    integer i;

    // always @(posedge recv_done) begin
    //     // cnt <= 0;
    //     num <= 7'd1;
    //     // for(i=0;i<MAX_CAP;i=i+1) cache[i]<=8'b0;
    //     item_num<=4'd5;
    //     cap<=8'd5;
    //     for(j=0;j<MAX_ITEM;j=j+1) begin
    //         weight[j] <= out_weight;
    //         value[j] <= out_value;
    //         num <= num + 7'd1;  // num <= index[j];
    //     end
    // end

    reg EN;
    reg [6:0] tmp;

    always @(posedge clk & num != MAX_ITEM & recv_done) begin
        if(start)begin
            num <= 7'd1;
            tmp <= 7'b0;
        end 
        else begin
            weight[tmp] <= out_weight;
            value[tmp] <= out_value;
            num <= num + 7'd1;
            tmp <= tmp + 7'd1;
        end
        if(num==MAX_ITEM-1) EN <= 1'b1;
        else EN <= 1'b0;
    end

    always @(posedge CLK_10 & cnt!=item_num+1 & EN == 1'b1) begin
        if (reset) begin
            cnt <= 1'b0;

        //     num <= 7'd1;
            for(i=0;i<MAX_CAP;i=i+1) cache[i]<=8'b0;
        //     item_num<=4'd5;
        //     cap<=8'd5;
        //     for(i=0;i<MAX_CAP;i=1+1) begin
        //         weight[i] <= out_weight;
        //         value[i] <= out_value;
        //         num <= num + 7'd1;
        //     end
        end
        else begin
            // todo parallel 非阻塞赋值？ 根据内容动态调整for?
            for(i=MAX_CAP-1;i>=0;i=i-1) 
                cache[i]<=
                    (cache[i]>(cache[i-weight[cnt]]+value[cnt]) | i < weight[cnt])?
                        cache[i]:(cache[i-weight[cnt]]+value[cnt]);
            $display("cnt=%d, cache=",cnt, cache[0] ,cache[1],cache[2] ,cache[3], cache[4], cache[5]);
            cnt <= cnt+1;
        end
    end

    clk_gen clk_1k(.clk(clk),.reset(reset),.clk_1K(CLK_1K));
    clk_gen1 clk_10(.clk(clk),.reset(reset),.clk_10(CLK_10));
    show SHOW(.clk(CLK_1K),.cache(cache[5]),.AN(AN),.cathodes(cathodes));

    UART_MEM uart(.clk(clk),.rst(reset),
            .mem2uart(mem2uart),
            .Rx_Serial(Rx_Serial),
            .recv_done(recv_done),
            .send_done(send_done),
            .Tx_Serial(Tx_Serial),
            .num(num),
            .out_value(out_value),
            .out_weight(out_weight));

endmodule //top