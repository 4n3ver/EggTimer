library verilog;
use verilog.vl_types.all;
entity Controller is
    generic(
        RESET           : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi0);
        SET_SEC         : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi0);
        SET_MIN         : vl_logic_vector(2 downto 0) := (Hi0, Hi0, Hi1);
        READY           : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi1);
        TIMER           : vl_logic_vector(2 downto 0) := (Hi0, Hi1, Hi0);
        FLASH_OFF       : vl_logic_vector(2 downto 0) := (Hi1, Hi1, Hi0);
        FLASH_ON        : vl_logic_vector(2 downto 0) := (Hi1, Hi0, Hi1);
        SETTING_MIN     : vl_logic_vector(2 downto 0) := (Hi1, Hi1, Hi1)
    );
    port(
        state           : out    vl_logic_vector(2 downto 0);
        key             : in     vl_logic_vector(2 downto 0);
        clk             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RESET : constant is 2;
    attribute mti_svvh_generic_type of SET_SEC : constant is 2;
    attribute mti_svvh_generic_type of SET_MIN : constant is 2;
    attribute mti_svvh_generic_type of READY : constant is 2;
    attribute mti_svvh_generic_type of TIMER : constant is 2;
    attribute mti_svvh_generic_type of FLASH_OFF : constant is 2;
    attribute mti_svvh_generic_type of FLASH_ON : constant is 2;
    attribute mti_svvh_generic_type of SETTING_MIN : constant is 2;
end Controller;
