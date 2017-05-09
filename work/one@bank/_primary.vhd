library verilog;
use verilog.vl_types.all;
entity oneBank is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        speed           : in     vl_logic_vector(2 downto 0);
        start           : in     vl_logic;
        \out\           : out    vl_logic_vector(4 downto 0);
        stop            : in     vl_logic
    );
end oneBank;
