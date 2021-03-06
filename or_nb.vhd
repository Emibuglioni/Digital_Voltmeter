--or n bits
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity or_nb is

  generic (N : integer) ;

  port(

    in_or : in std_logic_vector (N-1 downto 0) ;
    out_or : out std_logic

  );

end;

architecture or_nb_arq of or_nb is

    signal temp : std_logic_vector (N-1 downto 0) ; --señal temporal

  begin

    temp(0) <= in_or (0) ;

  or_nb: for i in 1 to N-1 generate

    temp(i) <= temp(i-1) or in_or(i) ;

  end generate;

  out_or <= temp(N-1) ;

end;
