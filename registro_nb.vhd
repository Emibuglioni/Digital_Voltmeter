--Registro n bits
library IEEE;
use IEEE.std_logic_1164.all ;


entity reg_nb is

  generic ( N : integer ) ;

  port(

    clk : in std_logic ;
    ena : in std_logic ;
    arst : in std_logic ;

    in_reg : in std_logic_vector ( N-1 downto 0 ) ;
    out_reg : out std_logic_vector (N-1 downto 0 )


  );

end ;

architecture reg_nb_arq of reg_nb is

  begin

  reg_nb : for i in 0 to N-1 generate

  reg_i : entity work.ffd

  port map(

    clk => clk ,
    arst => arst ,
    srst => '0' ,
    ena => ena ,
    D => in_reg( i ) ,
    Q => out_reg( i )

  );
  end generate ;

end ;
