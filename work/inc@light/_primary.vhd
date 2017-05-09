library verilog;
use verilog.vl_types.all;
entity incLight is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        start           : in     vl_logic;
        speed           : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(2 downto 0)
    );
end incLight;
