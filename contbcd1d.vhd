-- contador bcd 1 digito
library IEEE;
use IEEE.std_logic_1164.all;

entity contaBCD1d is
  port(
  clk : in std_logic ;
  arst : in std_logic ;
  srst : in std_logic ;
  ena : in std_logic ;
  out_nine : out std_logic ;
  out_BCD : out std_logic_vector ( 3 downto 0 )
  );
end ;

architecture contaBCD1d_arq of contaBCD1d is

  signal out_comp : std_logic ;
  signal srst_int : std_logic ;
  signal q2out : std_logic_vector(3 downto 0) ;

  begin

  contaBCD1D : entity work.contanb
    generic map(
      N => 4
    )
    port map(
      in_conta => "11" ,
      clk => clk ,
      arst => arst ,
      srst => srst_int ,
      ena => ena ,
      q => q2out
    );

    out_comp <= q2out(3) and not(q2out(2)) and not(q2out(1)) and q2out(0) ;
    srst_int <= srst or (out_comp and ena) ;
    out_nine <= out_comp ;
    out_BCD <= q2out ;

end ;
