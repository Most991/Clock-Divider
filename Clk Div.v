module Clk_Div(
    input wire ref_clk,
    input wire rst,
    input wire i_clk_en,
    input wire [7:0] div_ratio,
    output wire o_div_clk
);

wire [6:0] invert_value;
wire clk_en;
wire even;
reg  div_clk;
reg  flag;
reg [6:0] edge_cnt;

assign clk_en = i_clk_en && (div_ratio != 0) && (div_ratio != 1);
assign invert_value = div_ratio >> 1;
assign even = !div_ratio[0];
assign o_div_clk = (clk_en) ? div_clk : ref_clk;

always @(posedge ref_clk or negedge rst) begin
    if (!rst) begin
        div_clk <= 1'b0;
        edge_cnt <= 7'd0;
        flag <= 1'b0;
    end else if (clk_en && even) begin
        edge_cnt <= edge_cnt + 1;
        if (edge_cnt == invert_value) begin
            div_clk <= ~div_clk;
            edge_cnt <= 7'd1;
        end
    end else if (clk_en && !even) begin
        edge_cnt <= edge_cnt + 1;
        if (edge_cnt == invert_value && !flag) begin
            div_clk <= ~div_clk;
            edge_cnt <= 7'd1;
            flag <= 1'b1;
        end else if (edge_cnt == invert_value + 1 && flag) begin
            div_clk <= ~div_clk;
            edge_cnt <= 7'd1;
            flag <= 1'b0;
        end
    end
end

endmodule

