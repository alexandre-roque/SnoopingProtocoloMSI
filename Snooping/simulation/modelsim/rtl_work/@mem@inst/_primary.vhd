library verilog;
use verilog.vl_types.all;
entity MemInst is
    port(
        endereco        : in     vl_logic_vector(7 downto 0);
        instr           : out    vl_logic_vector(15 downto 0)
    );
end MemInst;
