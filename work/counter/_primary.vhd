library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        lastLED         : in     vl_logic;
        defeat          : in     vl_logic;
        \out\           : out    vl_logic_vector(2 downto 0);
        count           : in     vl_logic
    );
end counter;
