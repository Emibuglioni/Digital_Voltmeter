--ffd
library IEEE;
use IEEE.std_logic_1164.all;

--defino los pines de entrada y salida.
entity ffd is
	port(
		clk: in std_logic;
		arst: in std_logic; --reset asincronico
		srst: in std_logic; --reset sincronico
		ena: in std_logic; --habilitador del ffd
		D: in std_logic;
		Q: out std_logic
	);
end;

--defino la arquitectura de los pines para adentro.
architecture ffd_arq of ffd is

begin
	process(clk, arst) --es una sentencia como architecture, es un bloque que se ejecuta cada vez que hay un cambio en la lista de sensibilidad.
					--me permite sensar los argumentos(lista de sensibilidad).
	begin
		if arst = '1' then
			Q <= '0';
		elsif rising_edge(clk) then
			if srst = '1' then
				Q <= '0';
			elsif ena='1' then
				Q <= D;
			end if;
		end if;
	end process;

end;
