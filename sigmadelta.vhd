-- Block 1 : Sigma delta
-- Alumno: Emiliano Buglioni


library IEEE;
use IEEE.std_logic_1164.all;



entity sigmadelta is

    port(
        -- Entradas
        vin: in std_logic;
        -- Controles
        clk, arst, ena: in std_logic;
        -- Salida
        vout: out std_logic
    );

end;


architecture sigmadelta_arq of sigmadelta is
    begin
  
        registro: entity work.ffd
        port map(
            d => vin,
            clk => clk,
            arst => arst,
            srst => '0',
            ena => ena,
            q => vout
        );

end;
