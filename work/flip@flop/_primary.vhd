library verilog;
use verilog.vl_types.all;
entity flipFlop is
    port(
        Q               : out    vl_logic;
        D               : in     vl_logic;
        Reset           : in     vl_logic;
        clk             : in     vl_logic
    );
end flipFlop;
