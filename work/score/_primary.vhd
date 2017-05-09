library verilog;
use verilog.vl_types.all;
entity score is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        onPoint         : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(4 downto 0);
        stop            : in     vl_logic
    );
end score;
