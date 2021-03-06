--contador hasta el numero b (en binario)
library IEEE;
use IEEE.std_logic_1164.all;


entity contnc is

  port(

    clk : in std_logic ;
    arst : in std_logic ;
    srst : in std_logic ;
    ena : in std_logic ;
    b : in std_logic_vector ; -- numero a comparar, lo tengo que pasar en binario

    out_cont : out std_logic ;
    out_reg : out std_logic_vector

  );

end ;

architecture contnc_arq of contnc is

  signal q2a : std_logic_vector ( b'length-1 downto 0 ) ;
  signal srst_int : std_logic ;
  signal equal2srst : std_logic ;

  begin

    contanb : entity work.contanb

    generic map(

      N => b'length

    )

    port map(

      in_conta => "11" ,
      clk => clk ,
      arst => arst ,
      srst => srst_int ,
      ena => ena ,
      q => q2a

    );

    compnb_i : entity work.comp_nb

    generic map(

      N => b'length

    )

    port map(

    ena => ena ,
    a => q2a ,
    b => b ,

    high => open ,
    equal => equal2srst ,
    minor => open

    );

  out_cont <= equal2srst ;
  out_reg <= q2a ;
  srst_int <= srst or equal2srst ; --resetea cuando debe o bien por una señal externa.
end;
