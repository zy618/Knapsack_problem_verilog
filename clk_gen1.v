module clk_gen1(
    clk, 
    reset, 
    clk_10
);

input           clk;
input           reset;
output          clk_10;

reg             clk_10;

parameter   CNT = 32'd5000000;

reg     [32:0]  count;

always @(posedge clk or posedge reset)
begin
    if(reset) begin
        clk_10 <= 1'b0;
        count <= 32'd0;
    end
    else begin
        count <= (count==CNT-32'd1) ? 32'd0 : count + 32'd1;
        clk_10 <= (count==32'd0) ? ~clk_10 : clk_10;
    end
end

endmodule