library verilog;
use verilog.vl_types.all;
entity MaquinaDeEstados is
    port(
        estado          : in     vl_logic_vector(1 downto 0);
        estadoResultante: out    vl_logic_vector(1 downto 0);
        EscritaLeitura  : in     vl_logic;
        HitMiss         : in     vl_logic;
        \bus\           : out    vl_logic_vector(1 downto 0);
        writeback       : out    vl_logic;
        Run             : in     vl_logic
    );
end MaquinaDeEstados;
