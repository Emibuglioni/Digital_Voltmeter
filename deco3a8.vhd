-- Decodificador 3a8

library IEEE;
use IEEE.std_logic_1164.all;

--defino los pines de entrada y salida.
entity deco3a8 is

	port(
		--e0,e1,e2: in std_logic; 				--entradas de datos
		ena : in std_logic;     				--entrada de habilitacion
		--s0,s1,s2,s3,s4,s5,s6,s7: out std_logic  --salidas.
		in_deco : in std_logic_vector( 2 downto 0 ) ;
		out_deco : out std_logic_vector (7 downto 0 )

	);
end;

--defino la arquitectura de los pines para adentro.
architecture deco3a8_arq of deco3a8 is

begin
	out_deco(0) <= ena and not(in_deco(2)) and not(in_deco(1)) and not(in_deco(0));
	out_deco(1) <= ena and not(in_deco(2)) and not(in_deco(1)) and in_deco(0);
	out_deco(2) <= ena and not(in_deco(2)) and in_deco(1) and not(in_deco(0));
	out_deco(3) <= ena and not(in_deco(2)) and in_deco(1) and in_deco(0);
	out_deco(4) <= ena and in_deco(2) and not(in_deco(1)) and not(in_deco(0));
	out_deco(5) <= ena and in_deco(2) and not(in_deco(1)) and in_deco(0);
	out_deco(6) <= ena and in_deco(2) and in_deco(1) and not(in_deco(0));
	out_deco(7) <= ena and in_deco(2) and in_deco(1) and in_deco(0);
end;
