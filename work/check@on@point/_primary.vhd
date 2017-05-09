library verilog;
use verilog.vl_types.all;
entity checkOnPoint is
    generic(
        none            : vl_logic_vector(1 downto 0) := (Hi0, Hi0);
        plus1           : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        plus2           : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        minus2          : vl_logic_vector(1 downto 0) := (Hi1, Hi1)
    );
    port(
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        \in\            : in     vl_logic;
        allOff          : in     vl_logic;
        harder          : in     vl_logic;
        column          : in     vl_logic_vector(4 downto 0);
        point           : out    vl_logic_vector(1 downto 0);
        stop            : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of none : constant is 2;
    attribute mti_svvh_generic_type of plus1 : constant is 2;
    attribute mti_svvh_generic_type of plus2 : constant is 2;
    attribute mti_svvh_generic_type of minus2 : constant is 2;
end checkOnPoint;
