create_clock [get_ports ui_in[0]]  -name launch_clk  -period 14
create_clock [get_ports ui_in[1]]  -name capture_clk  -period 14
create_clock [get_ports clk]  -name base_clk  -period 14
set_clock_groups -asynchronous \
   -group [get_clocks {launch_clk}] \
   -group [get_clocks {capture_clk} \
   -group [get_clocks {base_clk}]
