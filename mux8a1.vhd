-- Multiplexor 8a1

library IEEE;
use IEEE.std_logic_1164.all;

--defino los pines de entrada y salida.
entity mux8a1 is 
	port(
		e0,e1,e2,e3,e4,e5,e6,e7: in std_logic; --entradas de dato.
		c0,c1,c2: in std_logic;       		   --entradas de control.
		s: out std_logic	       	  		   --salidas 
	);
end;

--defino la arquitectura de los pines para adentro.
architecture mux8a1_arq of mux8a1 is

begin
	s <= (e0 and not(c0) and not(c1) and not(c2)) or (e1 and not(c0) and not(c1) and c2) or (e2 and not(c0) and c1 and not(c2))
	or (e3	and not(c0) and c1 and c2) or (e4 and c0 and not(c1) and not(c2)) or (e5 and c0 and not(c1) and c2) or (e6 and c0 and c1 and not(c2))
	or (e7 and c0 and c1 and c2);
end;