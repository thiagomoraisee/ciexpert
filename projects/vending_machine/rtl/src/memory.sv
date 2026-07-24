module memory #(
  parameter PRICE_COFFEE = 8'h19,
  parameter PRICE_WATER  = 8'h32,
  parameter PRICE_JUICE  = 8'h4B,
  parameter PRICE_SNACK  = 8'h64,
  parameter STOCK_COFFEE = 8'h05,
  parameter STOCK_WATER  = 8'h05,
  parameter STOCK_JUICE  = 8'h03,
  parameter STOCK_SNACK  = 8'h02
)(
  input  logic       clk,
  input  logic       rst,
  input  logic       mem_read,
  input  logic       mem_write,
  input  logic [1:0] sel_item,
  output logic [7:0] price,
  output logic [7:0] stock
);

logic [15:0] mem [0:3];

always_ff @(posedge clk or posedge rst) begin
  if(rst) begin
    mem[0] <= {PRICE_COFFEE, STOCK_COFFEE};
    mem[1] <= {PRICE_WATER, STOCK_WATER};
    mem[2] <= {PRICE_JUICE, STOCK_JUICE};
    mem[3] <= {PRICE_SNACK, STOCK_SNACK};
  end else begin
    if(mem_read) begin
      price <= mem[sel_item][15:8];
      stock <= mem[sel_item][7:0];
    end
    if(mem_write) begin
      mem[sel_item][7:0] <= mem[sel_item][7:0] - 1;
    end
  end
end

endmodule
