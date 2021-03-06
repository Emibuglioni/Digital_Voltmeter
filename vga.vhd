-- Block 3: VGA
-- Alumno: Emiliano Buglioni

library IEEE;
use IEEE.std_logic_1164.all;

entity VGA is

  port(

    clk : in std_logic ;
    arst : in std_logic ;
    ADC2VGA : in std_logic_vector( 11 downto 0 ) ;
    ena : in std_logic ;

    H_sync : out std_logic ;
    V_sync : out std_logic ;
    red : out std_logic ;
    green : out std_logic ;
    blue : out std_logic

  ) ;

end ;

architecture VGA_arq of VGA is

  signal reg2mux : std_logic_vector( 11 downto 0 ) ;

  signal mux2rom : std_logic_vector( 3 downto 0 ) ;

  signal hsync2reg : std_logic ;
  signal H_view2and : std_logic ;
  signal conth2mux_rom : std_logic_vector( 9 downto 0 ) ;
  signal conth2ena : std_logic ;

  signal vsync2reg : std_logic ;
  signal V_view2and : std_logic ;
  signal contv2deco_rom : std_logic_vector( 9 downto 0 ) ;
  signal contv2reg : std_logic ;

  signal deco2and : std_logic_vector( 7 downto 0 ) ;

  signal rom2and : std_logic ;

  signal and2reg : std_logic ;

  signal out_RGB : std_logic ;

  begin

    CONTA_H : entity work.conta_h

      port map(

        clk => clk ,
        arst => arst ,
        srst => '0' ,
        ena => ena ,

        out_conth => conth2mux_rom ,
        v_cont => conth2ena ,
        h_sync => hsync2reg ,
        h_view => H_view2and

      ) ;

    CONTA_V : entity work.conta_v

      port map(

        clk => clk ,
        arst => arst ,
        srst => '0',
        ena => conth2ena ,

        out_contv => contv2deco_rom ,
        v_sync => vsync2reg ,
        v_view => V_view2and ,
        v_srst => contv2reg

      ) ;


    REG_tearing : entity work.reg_nb

      generic map(

        N => 12

        )

        port map(

        clk => clk ,
        ena  => contv2reg ,
        arst  => arst ,

        in_reg => ADC2VGA ,
        out_reg => reg2mux

        ) ;


    MUX_4in : entity work.mux4in

      generic map (

        N => 4

      )

      port map(

        d1 => reg2mux( 11 downto 8 ) ,
        p => "1010" ,
        d2 => reg2mux( 7 downto 4 ) ,
        d3 => reg2mux( 3 downto 0 ) ,
        v => "1011" ,
        sel => conth2mux_rom( 9 downto 7 ) , --ver que parte del vector va ahi.

        out_mux => mux2rom

      ) ;

    DECO : entity work.deco3a8

      port map(

        ena => ena ,
        in_deco => contv2deco_rom( 9 downto 7 ), --ver que parte del vector le pertenece.

        out_deco => deco2and

      ) ;

    ROM : entity work.rom

      port map(

        char_address => mux2rom ,
        sub_fila => contv2deco_rom( 6 downto 4 ) ,--ver que parte del vector le pertenece.
        sub_col => conth2mux_rom( 6 downto 4 ) ,

        rom_data => rom2and

      ) ;

    and2reg <= ( H_view2and and V_view2and ) and ( deco2and( 1 ) and rom2and  ) ;

  REG_1b_rom : entity work.ffd

    port map(

      clk => clk ,
      arst => arst ,
      srst => '0' ,
      ena => ena ,
      D => and2reg  ,
      Q => out_RGB

    ) ;

    red <= out_RGB ;
    green <= out_RGB ;
    blue <= out_RGB ;

    REG_1b_Hsync : entity work.ffd

      port map(

        clk => clk ,
        arst => arst ,
        srst => '0' ,
        ena => ena ,
        D => hsync2reg  ,
        Q => H_sync

      ) ;

    REG_1b_Vsync : entity work.ffd

      port map(

        clk => clk ,
        arst => arst ,
        srst => '0' ,
        ena => ena ,
        D => vsync2reg  ,
        Q => V_sync

      ) ;


end ;
