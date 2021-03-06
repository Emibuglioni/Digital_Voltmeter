-- contador n bits
library IEEE;
use IEEE.std_logic_1164.all;


entity contanb is

  generic (N : integer ); --defino un parametro n como entero.

  port (

    in_conta : in std_logic_vector (1 downto 0) ;
    clk : in std_logic ;
    arst : in std_logic ;
    srst : in std_logic ;
    ena : in std_logic ;
    q : out std_logic_vector ( N-1 downto 0)
  );

end;

architecture contanb_arq of contanb is

  signal out_xor : std_logic_vector (N-1 downto 0);
  signal out_and : std_logic_vector (N downto 0);
  signal out_ffd : std_logic_vector (N-1 downto 0);

  begin

    out_and(0) <= in_conta(0) and in_conta(1) ;


    contanbit: for i in 0 to N-1 generate

      out_xor(i) <= out_ffd(i) xor out_and(i) ;
      out_and(i+1) <= out_ffd(i) and out_and(i) ;

      ffd_i : entity work.ffd
        port map(

          clk => clk,
          arst => arst,
          srst => srst,
          ena => ena,
          D => out_xor(i),
          Q => out_ffd(i)

        );

      q(i) <= out_ffd(i) ;

    end generate;
end;
