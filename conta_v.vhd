--Cont VERTICAL view=480, fp=10, ps=2, bp=29
library IEEE;
use IEEE.std_logic_1164.all;


entity conta_v is

  port(

    clk : in std_logic ;
    arst : in std_logic ;
    srst : in std_logic ;
    ena : in std_logic ;

    out_contv : out std_logic_vector ;
    v_sync : out std_logic ;  -- pulso de sincronismo salida de la vga
    v_view : out std_logic ;    -- pulso que indica la parte visible
    v_srst : out std_logic

  ) ;

end ;

architecture conta_v_arq of conta_v is

  signal srst_int : std_logic ;
  signal equal2srst : std_logic ;
  signal cont2comp : std_logic_vector (9 downto 0) ;
  signal outhigh : std_logic ;
  signal outminor : std_logic ;

  signal screen_v : std_logic_vector(9 downto 0) := "1001111111" ;--639
  -- total view es el total de lineas verticales 640 ;
  signal view_vfp : std_logic_vector(9 downto 0) := "0111101001" ;--489
  -- suma de la cantidad de lineas visibles que es 480 mas el horizontal front porch que es 10
  -- en total es 480+10=490 ;
  signal view_vfp_ps : std_logic_vector(9 downto 0) := "0111101011" ;--491
  -- suma de la cantidad de lineas visibles que es 480 mas el horizontal front porch que es 10
  -- y el pulso de sincronismo que es 2 en total da 480+10+2=492
  signal view : std_logic_vector(9 downto 0) := "0111011111" ;--479
  -- es la cantidad de lineas visibles 480 ; 

  begin

    srst_int <= srst or equal2srst ;

    contanb : entity work.contanb

    generic map (

      N => 10

    )

    port map(

      in_conta => "11" ,
      clk => clk ,
      arst => arst ,
      srst => srst_int ,
      ena => ena,
      q => cont2comp

    ) ;

    out_contv <= cont2comp ;

  
    compnb1 : entity work.comp_nb

    generic map(

      N => 10

    )

    port map(

      ena => '1' ,
      a => cont2comp ,
      b => screen_v ,

      high => open ,
      equal => equal2srst ,
      minor => open

    ) ;

    v_srst <= equal2srst ;
    --Este segundo comparador me da cuando la cuenta es mayor a 489
    compnb2 : entity work.comp_nb

    generic map(

      N => 10

    )

    port map(

      ena => '1' ,
      a => cont2comp ,
      b => view_vfp ,

      high => outhigh ,
      equal => open ,
      minor => open

    ) ;

    -- Este tercer comparador me da cuando la cuenta es menor a 491
    compnb3 : entity work.comp_nb

    generic map(

      N => 10

    )

    port map(

      ena => '1' ,
      a => cont2comp ,
      b => view_vfp_ps ,

      high => open ,
      equal => open ,
      minor => outminor

    ) ;

    v_sync <= outhigh and outminor ;

    -- Este cuarto comparador me da la señal de pantalla visible
    compnb4 : entity work.comp_nb

    generic map(

      N => 10

    )

    port map(

      ena => '1' ,
      a => cont2comp ,
      b => view ,

      high => open ,
      equal => open ,
      minor => v_view

    ) ;

end ;
