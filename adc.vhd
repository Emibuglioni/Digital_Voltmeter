-- Block 2: ADC
-- Alumno: Emiliano Buglioni
library IEEE;
use IEEE.std_logic_1164.all ;


entity ADC is

  port(

    clk : in std_logic ;
    sigmadelta : in std_logic ;
    arst : in std_logic ;

    outADC : out std_logic_vector

  ) ;

end ;

architecture ADC_arq of ADC is

  signal  contbin2srst_ena : std_logic ;
  signal  contBCD2reg : std_logic_vector ( 27 downto 0 ) ; 
  signal visorcuenta : std_logic_vector ( 21 downto 0 ) ;  

  begin

  conta33000 : entity work.contnc

    port map(

      clk => clk ,
      arst => arst ,
      srst => '0' ,
      ena => '1' ,
      b =>  "1100100101101010100000",  -- Comparo con 3300000 en binario   

      out_cont => contbin2srst_ena ,
      out_reg => visorcuenta

    ) ;

  contaBCD : entity work.contaBCDnd

    generic map(

      N => 7 

    )

    port map(

      clk => clk ,
      arst => arst ,
      srst => contbin2srst_ena ,
      ena => sigmadelta ,

      out_BCD => contBCD2reg

    ) ;

  regADC : entity work.reg_nb

    generic map(

      N => 12 --4*3 = 12 registros

    )

    port map(

      clk => clk ,
      ena => contbin2srst_ena ,
      arst => arst ,

      in_reg => contBCD2reg( 27 downto 16 ) , 
      out_reg => outADC

    ) ;

end ;
