-- volt
-- Alumno: Emiliano Buglioni

library IEEE;
use IEEE.std_logic_1164.all ;

entity voltimetro is

  port(

    clk : in std_logic ;
    ena : in std_logic ;
    arst : in std_logic ;
	data_volt_in: in std_logic;
	SIGMA: out std_logic;
		
    R : out std_logic ;
    G : out std_logic ;
    B : out std_logic ;
    HS : out std_logic ;
    VS : out std_logic

  ) ;
 end; 

architecture voltimetro_arq of voltimetro is

  signal ADC2VGA : std_logic_vector( 11 downto 0 ) ;
  signal sigmadelta : std_logic ;
  
begin

	SIGMA <= not sigmadelta; --realimentacion negada
    
    sigmad: entity work.sigmadelta
	port map(
		vin => data_volt_in,
		clk => clk,
		arst => ARST,
		ena => ena,
		vout => sigmadelta
	);

  

    ADC : entity work.ADC

    port map(

      clk => clk ,
      sigmadelta =>  sigmadelta,
      arst => arst ,

      outADC => ADC2VGA

    ) ;

    VGA : entity work.VGA

    port map(

      clk => clk ,
      arst => arst ,
      ADC2VGA => ADC2VGA ,
      ena => ena ,

      H_sync => HS ,
      V_sync => VS ,
      red => R ,
      green => G ,
      blue => B

    ) ;

end ;


