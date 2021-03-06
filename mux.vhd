-- multiplexor de 3 entradas de seleccion con 8 entradas pero solo uso 5 que son las del
--digito 1, punto, digito 2, digito 3, letra vhdl donde todos son de 4 bits.
library IEEE ;
use IEEE.std_logic_1164.all ;


entity mux4in is

  generic ( N : integer );

  port(

    d1 : in std_logic_vector ( N-1 downto 0 ) ; -- entradas de datos
    p : in std_logic_vector ( N-1 downto 0 ) ;
    d2 : in std_logic_vector ( N-1 downto 0 ) ;
    d3 : in std_logic_vector ( N-1 downto 0 ) ;
    v : in std_logic_vector ( N-1 downto 0 ) ;

    sel : in std_logic_vector ( 2 downto 0 ) ; --entradas de seleccion

    out_mux : out std_logic_vector ( N-1 downto 0 )

  );

end;

architecture mux4in_arq of mux4in is

  begin

    mux4in : for i in 0 to N-1 generate

    mux8_i : entity work.mux8a1
      port map(

        e0 => d1(i) ,
        e1 => p(i) ,
        e2 => d2(i) ,
        e3 => d3(i) ,
        e4 => v(i) ,
        e5 => '0' ,
        e6 => '0' ,
        e7 => '0' ,
        c0 => sel(2) ,
        c1 => sel(1) ,
        c2 => sel(0) ,
        s => out_mux (i)

      );

    end generate ;

end;
