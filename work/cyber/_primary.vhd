library verilog;
use verilog.vl_types.all;
entity cyber is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        pressed         : in     vl_logic;
        pull            : out    vl_logic;
        stop            : in     vl_logic
    );
end cyber;
