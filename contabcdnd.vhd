-- contador bcd n digitos
library IEEE;
use IEEE.std_logic_1164.all;


entity contaBCDnd is

  generic ( N : integer ) ; -- Con N defino el numero de digitos

  port(

    clk : in std_logic ;
    arst : in std_logic ;
    srst : in std_logic ;
    ena : in std_logic ;

    out_BCD : out std_logic_vector ( (N*4)-1 downto 0 )

  ) ;

end ;

architecture contaBCDnd_arq of contaBCDnd is

  signal and2ena : std_logic_vector ( N downto 0 ) ;
  signal out_nine2and : std_logic_vector ( N  downto 0 ) ;

  begin

  out_nine2and(0) <= '1' ;
  and2ena(0) <= out_nine2and(0) and ena ;

  contaBCDnd : for i in 0 to N-1 generate

    contbcd1d_i : entity work.contaBCD1d

    port map(

    clk => clk ,
    arst => arst  ,
    srst => srst ,
    ena => and2ena(i) ,
    out_nine => out_nine2and(i+1) ,
    out_BCD => out_BCD(4*i+3 downto 4*i)

    ) ;

    and2ena(i+1) <= and2ena(i) and out_nine2and(i+1) ;

  end generate ;

end ;
