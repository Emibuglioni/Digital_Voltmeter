--Cont HORIZONTAL view=640, fp=16, ps=96, bp=48
library IEEE;
use IEEE.std_logic_1164.all;


entity conta_h is

  port(

    clk : in std_logic ;
    arst : in std_logic ;
    srst : in std_logic ;
    ena : in std_logic ;

    out_conth : out std_logic_vector ;
    v_cont : out std_logic ;   -- es el enable del contador vertical
    h_sync : out std_logic ;  -- pulso de sincronismo salida de la vga
    h_view : out std_logic    -- pulso que indica la parte visible

  ) ;

end ;

architecture conta_h_arq of conta_h is

  signal srst_int : std_logic ;
  signal equal2srst : std_logic ;
  signal cont2comp : std_logic_vector (9 downto 0) ;
  signal outhigh : std_logic ;
  signal outminor : std_logic ;

  signal screen_h : std_logic_vector(9 downto 0) := "1100011111" ;
  -- total view es el total de lineas horizontales 800 ;
  signal view_hfp : std_logic_vector(9 downto 0) := "1010011111" ;
  -- suma de la pantalla visible que es 640 mas el horizontal front porch que es 16
  -- en total es 640+32=672 ; 
  signal view_hfp_ps : std_logic_vector(9 downto 0) := "1011100000" ;
  -- suma de la pantalla visible que es 640 mas el horizontal front porch que es 32
  -- y el pulso de sincronismo que es 64 en total da 640+32+64=736
  signal view : std_logic_vector(9 downto 0) := "1001111111" ;
  -- es la zona de la pantalla visible 640 ;
 

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

    out_conth <= cont2comp ;

   
    compnb1 : entity work.comp_nb

    generic map(

      N => 10

    )

    port map(

      ena => '1' ,
      a => cont2comp ,
      b => screen_h ,

      high => open ,
      equal => equal2srst ,
      minor => open

    ) ;

    v_cont <= equal2srst ;

    --Este segundo comparador me da cuando la cuenta es mayor a 656
    compnb2 : entity work.comp_nb

    generic map(

      N => 10

    )

    port map(

      ena => '1' ,
      a => cont2comp ,
      b => view_hfp ,

      high => outhigh ,
      equal => open ,
      minor => open

    ) ;

    -- Este tercer comparador me da cuando la cuenta es menor a 751
    compnb3 : entity work.comp_nb

    generic map(

      N => 10

    )

    port map(

      ena => '1' ,
      a => cont2comp ,
      b => view_hfp_ps ,

      high => open ,
      equal => open ,
      minor => outminor

    ) ;

    h_sync <= outhigh and outminor ;

    -- Este cuarto comparador me da la señaal de pantalla visible
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
      minor => h_view

    ) ;

end ;
