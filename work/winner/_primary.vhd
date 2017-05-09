library verilog;
use verilog.vl_types.all;
entity winner is
    generic(
        leftWin         : vl_logic_vector(6 downto 0) := (Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0);
        rightWin        : vl_logic_vector(6 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1);
        none            : vl_logic_vector(6 downto 0) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        L               : in     vl_logic;
        R               : in     vl_logic;
        NL              : in     vl_logic;
        NR              : in     vl_logic;
        \out\           : out    vl_logic_vector(6 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of leftWin : constant is 2;
    attribute mti_svvh_generic_type of rightWin : constant is 2;
    attribute mti_svvh_generic_type of none : constant is 2;
end winner;
