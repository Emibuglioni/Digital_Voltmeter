-- comparador de n bits
library IEEE;
use IEEE.std_logic_1164.all;


entity comp_nb is

  generic (N : integer) ;

  port(

    ena : in std_logic ;
    a : in std_logic_vector (N-1 downto 0);
    b : in std_logic_vector (N-1 downto 0);

    high : out std_logic ; -- pone un 1 cuando a>b
    equal : out std_logic ; -- pone un 1 cuando a=b
    minor : out std_logic   -- pone un 1 cuando a<b

  );

end;

architecture comp_nb_arq of comp_nb is

  signal sout_1 : std_logic_vector (N-1 downto 0) ; --cables que salen de cada comparador de un bit
  signal sout_2 : std_logic_vector (N downto 0) ;
  signal sout_3 : std_logic_vector (N-1 downto 0) ;

  signal out1_parcial : std_logic ;
  signal out2_parcial : std_logic ;
  signal out3_parcial : std_logic ;


  begin

    sout_2(N) <= ena ;

    comp_nb: for i in 0 to N-1 generate

    comp_i: entity work.comp1bit

     port map(

      ena => sout_2(i+1),
      a => a(i),
      b => b(i),

      s1 => sout_1(i),
      s2 => sout_2(i),
      s3 => sout_3(i)

     );

  end generate;

    or_out1: entity work.or_nb
    generic map(

      N => N

    )

    port map(

      in_or => sout_1 ,
      out_or => out1_parcial

    );

    out2_parcial <= sout_2(0) ;

    or_out3: entity work.or_nb
    generic map(

      N => N

    )

    port map(

      in_or => sout_3 ,
      out_or => out3_parcial

    );

    high <= out1_parcial and not( out2_parcial ) and not( out3_parcial ) ;
    equal <= not( out1_parcial ) and out2_parcial and not( out3_parcial ) ;
    minor <= not( out1_parcial ) and not( out2_parcial ) and out3_parcial ;
end;
