library verilog;
use verilog.vl_types.all;
entity tickCounter is
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        speed           : in     vl_logic_vector(1 downto 0);
        tick            : out    vl_logic
    );
end tickCounter;
